import os
import cv2
import torch
from PIL import Image
import glob
from pathlib import Path


class PhotoEnhancer:
    def __init__(self, input_dir="entrada", output_dir="saida"):
        self.input_dir = input_dir
        self.output_dir = output_dir
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

        # Criar diretórios se não existirem
        os.makedirs(self.input_dir, exist_ok=True)
        os.makedirs(self.output_dir, exist_ok=True)

        print(f"Usando dispositivo: {self.device}")

    def load_models(self):
        """Carrega os modelos de IA para melhorar imagens"""
        try:
            # Tentar usar Real-ESRGAN para super-resolução
            from realesrgan import RealESRGANer
            self.enhancer = RealESRGANer(
                scale=4,
                model_path=None,  # Usará modelo padrão
                dni_weight=None,
                model_name='RealESRGAN_x4plus',
                tile=0,
                tile_pad=10,
                pre_pad=0,
                half=True if self.device.type != 'cpu' else False,
                device=self.device
            )
            self.model_type = "realesrgan"
            print("Modelo Real-ESRGAN carregado com sucesso!")
        except Exception as e:
            print(f"Real-ESRGAN não disponível: {e}")
            print("Usando métodos tradicionais...")
            self.model_type = "traditional"

    def enhance_traditional(self, image):
        """Métodos tradicionais de melhoria de imagem"""
        # Converter para RGB se necessário
        if len(image.shape) == 2:
            image = cv2.cvtColor(image, cv2.COLOR_GRAY2RGB)
        elif image.shape[2] == 4:
            image = cv2.cvtColor(image, cv2.COLOR_BGRA2RGB)
        else:
            image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

        # Aplicar filtros de melhoria
        # 1. Redução de ruído
        denoised = cv2.fastNlMeansDenoisingColored(image, None, 10, 10, 7, 21)

        # 2. Ajuste de contraste (CLAHE)
        lab = cv2.cvtColor(denoised, cv2.COLOR_RGB2LAB)
        lab_planes = list(cv2.split(lab))
        clahe = cv2.createCLAHE(clipLimit=2.0, tileGridSize=(8, 8))
        lab_planes[0] = clahe.apply(lab_planes[0])
        lab = cv2.merge(lab_planes)
        enhanced = cv2.cvtColor(lab, cv2.COLOR_LAB2RGB)

        # 3. Nitidez
        kernel = np.array([[-1, -1, -1], [-1, 9, -1], [-1, -1, -1]])
        sharpened = cv2.filter2D(enhanced, -1, kernel)

        return sharpened

    def enhance_with_ai(self, image_path):
        """Melhora a imagem usando IA"""
        try:
            if self.model_type == "realesrgan":
                # Usar Real-ESRGAN
                image = cv2.imread(image_path, cv2.IMREAD_UNCHANGED)
                enhanced, _ = self.enhancer.enhance(image)
                return enhanced
            else:
                # Usar métodos tradicionais
                image = cv2.imread(image_path)
                return self.enhance_traditional(image)

        except Exception as e:
            print(f"Erro ao processar {image_path}: {e}")
            return None

    def process_images(self):
        """Processa todas as imagens no diretório de entrada"""
        # Encontrar todas as imagens no diretório de entrada
        image_extensions = ['*.jpg', '*.jpeg', '*.png', '*.bmp', '*.tiff', '*.webp']
        image_paths = []

        for extension in image_extensions:
            image_paths.extend(glob.glob(os.path.join(self.input_dir, extension)))
            image_paths.extend(glob.glob(os.path.join(self.input_dir, extension.upper())))

        if not image_paths:
            print(f"Nenhuma imagem encontrada no diretório '{self.input_dir}'")
            return

        print(f"Encontradas {len(image_paths)} imagens para processar")

        for i, image_path in enumerate(image_paths):
            print(f"Processando {i + 1}/{len(image_paths)}: {os.path.basename(image_path)}")

            # Melhorar a imagem
            enhanced_image = self.enhance_with_ai(image_path)

            if enhanced_image is not None:
                # Salvar imagem melhorada
                output_path = os.path.join(
                    self.output_dir,
                    f"melhorada_{os.path.basename(image_path)}"
                )

                # Converter BGR para RGB se necessário e salvar
                if len(enhanced_image.shape) == 3 and enhanced_image.shape[2] == 3:
                    enhanced_image = cv2.cvtColor(enhanced_image, cv2.COLOR_BGR2RGB)

                cv2.imwrite(output_path, enhanced_image)
                print(f"Imagem salva: {output_path}")
            else:
                print(f"Falha ao processar: {image_path}")


def main():
    """Função principal"""
    print("=== MELHORADOR DE FOTOS ANTIGAS ===")
    print("Iniciando processamento...")

    # Inicializar o melhorador
    enhancer = PhotoEnhancer()

    # Carregar modelos
    enhancer.load_models()

    # Processar imagens
    enhancer.process_images()

    print("Processamento concluído!")


if __name__ == "__main__":
    # Adicionar import necessário para métodos tradicionais
    import numpy as np

    main()