---
name: Imagen
description: Generate images using Google Gemini's image generation API for UI mockups, icons, illustrations, and visual assets
author: sanjay3290
source: https://github.com/sanjay3290/ai-skills/tree/main/skills/imagen
version: 1.0
requirements:
  - Python 3.6+
  - GEMINI_API_KEY environment variable
---

# Imagen - Image Generation Skill

Generate images using Google Gemini's image generation model (`imagen-3.0-generate-001`) for various creative and development purposes.

## When to Use This Skill

**Use this skill when:**
- Need UI mockups or wireframes
- Creating placeholder images for frontend development
- Generating icons, logos, or illustrations
- Visualizing concepts or architecture diagrams
- Need visual assets for documentation
- Creating marketing materials or social media graphics

## Prerequisites

### API Key Setup

1. Get a Gemini API key from [Google AI Studio](https://aistudio.google.com/app/apikey)
2. Set the environment variable:

```bash
export GEMINI_API_KEY="your-api-key-here"
```

Or for persistent setup, add to your shell profile:

```bash
# In ~/.bashrc or ~/.zshrc
export GEMINI_API_KEY="your-api-key-here"
```

### Verification

Check if the API key is set:

```bash
echo $GEMINI_API_KEY
```

## How to Use

### Basic Usage

**Generate an image with a text prompt:**

```bash
python scripts/generate_image.py "A modern minimalist logo for a tech startup"
```

Output: `generated_image.png` in current directory

### Specify Output Path

```bash
python scripts/generate_image.py "Isometric view of a cloud server infrastructure" output/server-diagram.png
```

### Specify Image Size

```bash
python scripts/generate_image.py "2K resolution" "Mobile app login screen with gradient background"
```

## Image Generation Script

Save this as `scripts/generate_image.py`:

```python
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
```

Make it executable:

```bash
chmod +x scripts/generate_image.py
```

### Install Dependencies

```bash
pip install google-generativeai
```

Or add to `requirements.txt`:

```
google-generativeai>=0.3.0
```

## Example Prompts

### UI/UX Design

```bash
# Mobile app UI
python scripts/generate_image.py "Clean iOS app login screen with email and password fields, modern gradient background, minimalist design"

# Web dashboard
python scripts/generate_image.py "Analytics dashboard mockup with charts, graphs, and KPI cards, professional corporate design"

# Landing page
python scripts/generate_image.py "SaaS landing page hero section, modern tech startup aesthetic, call-to-action button"
```

### Icons & Logos

```bash
# App icon
python scripts/generate_image.py "Mobile app icon for task management app, minimalist, blue and white color scheme, 1024x1024"

# Logo
python scripts/generate_image.py "Tech company logo, abstract geometric shape, professional, vector-style"

# Icon set
python scripts/generate_image.py "Set of 8 UI icons for settings, profile, notifications, search, modern line art style"
```

### Technical Diagrams

```bash
# Architecture diagram
python scripts/generate_image.py "Cloud architecture diagram showing microservices, API gateway, load balancer, database cluster, isometric view"

# Flowchart
python scripts/generate_image.py "User authentication flow chart, clean professional style with decision points"

# System diagram
python scripts/generate_image.py "Network topology diagram for enterprise infrastructure, servers, routers, firewalls"
```

### Marketing & Content

```bash
# Social media
python scripts/generate_image.py "Instagram post graphic for tech announcement, gradient background, modern typography space"

# Blog header
python scripts/generate_image.py "Blog post header image about AI and machine learning, futuristic abstract design"

# Presentation slide
python scripts/generate_image.py "Title slide background for tech presentation, professional gradient, subtle geometric patterns"
```

## Best Practices

### Writing Good Prompts

**Be Specific:**
❌ Bad: "A website"
✅ Good: "Modern SaaS landing page with hero section, feature cards, and pricing table"

**Specify Style:**
❌ Bad: "App icon"
✅ Good: "Minimalist app icon with rounded corners, gradient from blue to purple, iOS style"

**Include Context:**
❌ Bad: "Dashboard"
✅ Good: "Analytics dashboard mockup in dark mode, showing revenue charts and user metrics"

**Mention Quality:**
❌ Bad: "Logo design"
✅ Good: "Professional vector-style logo, high resolution, suitable for print and digital"

### Prompt Formula

```
[Subject] + [Style] + [Details] + [Quality/Format]

Example:
"Mobile login screen" + "modern minimalist design" + "with email field, password field, and Google sign-in button" + "clean professional UI, suitable for iOS app"
```

## Troubleshooting

### API Key Issues

**Error:** `GEMINI_API_KEY environment variable not set`

**Solution:**
```bash
# Check if set
echo $GEMINI_API_KEY

# Set temporarily
export GEMINI_API_KEY="your-key-here"

# Set permanently (add to ~/.bashrc or ~/.zshrc)
echo 'export GEMINI_API_KEY="your-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### Generation Failures

**Error:** `Image generation failed`

**Common causes:**
- Prompt violates content policy (violence, nudity, etc.)
- Prompt too vague or ambiguous
- Network connectivity issues
- API quota exceeded

**Solution:** Refine prompt, check internet connection, verify API key is valid

### Image Quality Issues

**Problem:** Generated image doesn't match expectations

**Solutions:**
- Add more details to prompt
- Specify art style explicitly (e.g., "photorealistic", "vector illustration", "watercolor")
- Try different variations of the prompt
- Add quality keywords: "high resolution", "professional", "detailed"

## Integration with Development Workflow

### Use in Frontend Development

```bash
# Generate placeholder images
python scripts/generate_image.py "User profile avatar placeholder, neutral gray silhouette" assets/avatar-placeholder.png

# Create icon variations
python scripts/generate_image.py "Home icon, outline style, 64x64" assets/icons/home.png
```

### Documentation

```bash
# Architecture diagrams
python scripts/generate_image.py "Microservices architecture diagram" docs/images/architecture.png

# Concept illustrations
python scripts/generate_image.py "Diagram showing OAuth2 authentication flow" docs/images/oauth-flow.png
```

### Prototyping

```bash
# Rapid mockup generation
for page in "login" "dashboard" "profile" "settings"; do
  python scripts/generate_image.py "Modern mobile app $page screen" mockups/${page}.png
done
```

## Limitations

- **Content Policy:** Cannot generate violent, adult, or copyrighted content
- **Consistency:** Multiple generations may vary (not deterministic)
- **Text in Images:** Generated text may be garbled or incorrect
- **Specific Brands:** Cannot accurately reproduce specific brand logos or trademarks
- **People:** Generated faces are synthetic, not real people

## Alternatives & Comparisons

| Feature | Imagen (Gemini) | DALL-E (OpenAI) | Midjourney |
|---------|----------------|-----------------|------------|
| API Access | ✅ Yes | ✅ Yes | ❌ No (Discord only) |
| Free Tier | ✅ Yes | ⚠️ Limited | ❌ No |
| Speed | ⚡ Fast (10-30s) | ⚡ Fast | ⚠️ Slower |
| Quality | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Customization | ⚠️ Limited | ✅ Good | ✅ Excellent |

## Advanced Usage

### Batch Generation

```python
prompts = [
    "Login screen mockup",
    "Dashboard mockup",
    "Profile page mockup",
]

for i, prompt in enumerate(prompts):
    generate_image(prompt, f"output/screen_{i+1}.png")
```

### Integration with CI/CD

```yaml
# .github/workflows/generate-assets.yml
name: Generate Image Assets

on:
  workflow_dispatch:
    inputs:
      prompt:
        description: 'Image generation prompt'
        required: true

jobs:
  generate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'
      - name: Install dependencies
        run: pip install google-generativeai
      - name: Generate image
        env:
          GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
        run: python scripts/generate_image.py "${{ github.event.inputs.prompt }}" output/generated.png
```

---

**Quick Start:**
1. Get API key from https://aistudio.google.com/app/apikey
2. `export GEMINI_API_KEY="your-key"`
3. `pip install google-generativeai`
4. `python scripts/generate_image.py "Your creative prompt here"`

**Remember:** Be specific with prompts, specify style and quality, and respect content policies.
