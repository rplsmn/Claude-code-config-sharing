#!/usr/bin/env python3
"""
Imagen - Google Gemini Image Generation
Generates images from text prompts using Gemini's imagen model
"""

import os
import sys
import google.generativeai as genai
from pathlib import Path

def generate_image(prompt: str, output_path: str = "generated_image.png", size: str = "1024x1024") -> bool:
    """
    Generate an image using Google Gemini's imagen model

    Args:
        prompt: Text description of the desired image
        output_path: Where to save the generated image (default: generated_image.png)
        size: Image dimensions (default: 1024x1024)

    Returns:
        bool: True if successful, False otherwise
    """

    # Validate API key
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("ERROR: GEMINI_API_KEY environment variable not set", file=sys.stderr)
        print("\nTo fix this:", file=sys.stderr)
        print("1. Get API key from https://aistudio.google.com/app/apikey", file=sys.stderr)
        print("2. export GEMINI_API_KEY='your-key-here'", file=sys.stderr)
        return False

    try:
        # Configure Gemini
        genai.configure(api_key=api_key)

        # Use imagen model for image generation
        model = genai.GenerativeModel('imagen-3.0-generate-001')

        print(f"Generating image: {prompt}")
        print(f"Size: {size}")
        print("This may take 10-30 seconds...")

        # Generate the image
        response = model.generate_content(
            prompt,
            generation_config={
                "temperature": 0.4,
                "top_p": 1,
                "top_k": 32,
                "max_output_tokens": 4096,
            }
        )

        # Save the image
        if response.parts and len(response.parts) > 0:
            image_data = response.parts[0].inline_data.data

            # Create output directory if needed
            output_file = Path(output_path)
            output_file.parent.mkdir(parents=True, exist_ok=True)

            # Write image file
            with open(output_file, 'wb') as f:
                f.write(image_data)

            print(f"✅ Image saved to: {output_file.absolute()}")
            return True
        else:
            print("ERROR: No image generated", file=sys.stderr)
            return False

    except Exception as e:
        print(f"ERROR: Image generation failed: {str(e)}", file=sys.stderr)
        return False

def main():
    """CLI entry point"""

    if len(sys.argv) < 2:
        print("Usage: python generate_image.py <prompt> [output_path] [size]")
        print("\nExamples:")
        print('  python generate_image.py "Modern tech logo"')
        print('  python generate_image.py "UI mockup" output/mockup.png')
        print('  python generate_image.py "2K resolution" "Server diagram"')
        sys.exit(1)

    prompt = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else "generated_image.png"
    size = sys.argv[3] if len(sys.argv) > 3 else "1024x1024"

    success = generate_image(prompt, output_path, size)
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
