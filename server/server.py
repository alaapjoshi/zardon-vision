import time
start_time = time.time()
from transformers import VisionEncoderDecoderModel, ViTImageProcessor, AutoTokenizer
import torch
from PIL import Image
from flask import Flask, request
import os

model = VisionEncoderDecoderModel.from_pretrained("nlpconnect/vit-gpt2-image-captioning")
feature_extractor = ViTImageProcessor.from_pretrained("nlpconnect/vit-gpt2-image-captioning")
tokenizer = AutoTokenizer.from_pretrained("nlpconnect/vit-gpt2-image-captioning")
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model.to(device)
max_length = 16
num_beams = 4
gen_kwargs = {"max_length": max_length, "num_beams": num_beams}
def predict_step(image_paths):
  images = []
  for image_path in image_paths:
    i_image = Image.open(image_path)
    if i_image.mode != "RGB":
      i_image = i_image.convert(mode="RGB")

    images.append(i_image)

  pixel_values = feature_extractor(images=images, return_tensors="pt").pixel_values
  pixel_values = pixel_values.to(device)

  output_ids = model.generate(pixel_values, **gen_kwargs)

  preds = tokenizer.batch_decode(output_ids, skip_special_tokens=True)
  preds = [pred.strip() for pred in preds]
  return preds

print("Done with setup in %s seconds " % round(time.time() - start_time))

IMAGE_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "images", "image.png")
os.makedirs(os.path.dirname(IMAGE_PATH), exist_ok=True)

app = Flask(__name__)

@app.route('/saveimage', methods=['POST'])
def save_image():
    if 'file' not in request.files:
        return 'No file uploaded', 400
    file = request.files['file']
    if file.filename == '':
        return 'No file uploaded', 400
    file.save(IMAGE_PATH)
    print("Successful")
    results = predict_step([IMAGE_PATH])
    results = results[0]
    print(results)
    print("Processed")
    return results, 200

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=20100)