import tensorflow as tf
import tensorflow_hub as hub
import matplotlib.pyplot as plt
import numpy as np
import PIL.Image
import urllib.request


def download_image(url, filename):
    urllib.request.urlretrieve(url, filename)
    print(f"Imagem {filename} baixada com sucesso")


url_content = "https://br.trace.tv/wp-content/uploads/2023/12/01-10-2.png"
url_style = "https://cdn.prod.website-files.com/6331f2cd9d4e44f039dc4065/66bfe213b66e986ec3e63915_vicent-van-gogh.jpg"

download_image(url_content, "content.jpg")
download_image(url_style, "style.jpg")


def load_imagem(path_to_img, max_dim=512):
    img = tf.io.read_file(path_to_img)
    img = tf.image.decode_image(img, channels=3)
    img = tf.image.convert_image_dtype(img, tf.float32)
    shape = tf.cast(tf.shape(img)[:-1], tf.float32)
    long_dim = max(shape)
    scale = max_dim / long_dim
    new_shape = tf.cast(shape * scale, tf.int32)
    img = tf.image.resize(img, new_shape)
    img = img[tf.newaxis, :]
    return img


content_image = load_imagem("content.jpg")
style_image = load_imagem("style.jpg")


def show_images(content, style):
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.imshow(tf.squeeze(content))
    plt.title("Imagem de conteúdo")
    plt.axis('off')

    plt.subplot(1, 2, 2)
    plt.imshow(tf.squeeze(style))
    plt.title("Imagem de estilo")
    plt.axis('off')
    plt.show()


show_images(content_image, style_image)

hub_model = hub.load('https://tfhub.dev/google/magenta/arbitrary-image-stylization-v1-256/2')
stylized_image = hub_model(tf.constant(content_image), tf.constant(style_image))[0]

plt.figure(figsize=(10, 5))
plt.imshow(tf.squeeze(stylized_image))
plt.title("Imagem com Estilo Transferido")
plt.axis('off')
plt.show()