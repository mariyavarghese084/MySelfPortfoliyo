import os
import math
from PIL import Image, ImageDraw, ImageFilter

def create_app_icons():
    # Render at 4096x4096 (4x scale) for ultra-sharp antialiasing
    SIZE = 4096
    CENTER = SIZE // 2
    
    # Theme Palette from lib/app/theme/app_colors.dart
    # Primary Accent: #E85D4A (Warm Coral Accent)
    # Dark Background: #0F172A (Slate Obsidian Dark)
    COLOR_PRIMARY = (232, 93, 74, 255)       # #E85D4A
    COLOR_WHITE = (255, 255, 255, 255)        # Crisp White
    COLOR_BG_DARK = (15, 23, 42, 255)         # #0F172A
    COLOR_BG_DARK_OUTER = (11, 17, 32, 255)   # #0B1120 Deep Slate

    # -------------------------------------------------------------
    # 1. Full Background Image (for app_icon.png)
    # -------------------------------------------------------------
    bg_img = Image.new("RGBA", (SIZE, SIZE), COLOR_BG_DARK_OUTER)
    bg_draw = ImageDraw.Draw(bg_img)

    # Smooth subtle radial background gradient
    max_radius = SIZE * 0.75
    for r in range(int(max_radius), 0, -8):
        t = r / max_radius
        # Interpolate between inner slate #0F172A and outer #0B1120
        red = int(COLOR_BG_DARK[0] * (1 - t) + COLOR_BG_DARK_OUTER[0] * t)
        green = int(COLOR_BG_DARK[1] * (1 - t) + COLOR_BG_DARK_OUTER[1] * t)
        blue = int(COLOR_BG_DARK[2] * (1 - t) + COLOR_BG_DARK_OUTER[2] * t)
        bg_draw.ellipse(
            [CENTER - r, CENTER - r, CENTER + r, CENTER + r],
            fill=(red, green, blue, 255)
        )

    # Add soft warm primary coral radial glow in center
    glow_img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    glow_draw = ImageDraw.Draw(glow_img)
    glow_r = int(SIZE * 0.35)
    for r in range(glow_r, 0, -8):
        t = r / glow_r
        alpha = int(45 * (1.0 - math.pow(t, 1.3)))
        glow_draw.ellipse(
            [CENTER - r, CENTER - r, CENTER + r, CENTER + r],
            fill=(232, 93, 74, alpha)
        )
    bg_img = Image.alpha_composite(bg_img, glow_img)

    # -------------------------------------------------------------
    # 2. Monogram "MV" Vector Geometry
    # Fit comfortably inside Android Adaptive Icon Safe Circle (66% diameter = ~2700px at 4096)
    # Total Monogram Width: ~2100px, Height: ~1400px
    # Stroke Width: 260px (~65px at 1024px scale)
    # -------------------------------------------------------------
    STROKE_W = 260
    
    # "M" geometry
    m_left_x  = 1050
    m_mid_x   = 1550
    m_right_x = 2050
    
    y_top = 1350
    y_bot = 2750
    y_mid = 2300
    
    # "V" geometry
    v_left_x  = 2140
    v_mid_x   = 2590
    v_right_x = 3040

    def draw_rounded_stroke(draw, p1, p2, width, color):
        draw.line([p1, p2], fill=color, width=width)
        r = width // 2
        draw.ellipse([p1[0]-r, p1[1]-r, p1[0]+r, p1[1]+r], fill=color)
        draw.ellipse([p2[0]-r, p2[1]-r, p2[0]+r, p2[1]+r], fill=color)

    # Foreground Canvas for Logo (Transparent background)
    fg_img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))

    # A) Soft Shadow Layer for Depth
    shadow_img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    s_draw = ImageDraw.Draw(shadow_img)
    shadow_off_x, shadow_off_y = 35, 50
    shadow_color = (0, 0, 0, 190)

    # Shadow M
    draw_rounded_stroke(s_draw, (m_left_x + shadow_off_x, y_bot + shadow_off_y), (m_left_x + shadow_off_x, y_top + shadow_off_y), STROKE_W, shadow_color)
    draw_rounded_stroke(s_draw, (m_left_x + shadow_off_x, y_top + shadow_off_y), (m_mid_x + shadow_off_x, y_mid + shadow_off_y), STROKE_W, shadow_color)
    draw_rounded_stroke(s_draw, (m_mid_x + shadow_off_x, y_mid + shadow_off_y), (m_right_x + shadow_off_x, y_top + shadow_off_y), STROKE_W, shadow_color)
    draw_rounded_stroke(s_draw, (m_right_x + shadow_off_x, y_top + shadow_off_y), (m_right_x + shadow_off_x, y_bot + shadow_off_y), STROKE_W, shadow_color)

    # Shadow V
    draw_rounded_stroke(s_draw, (v_left_x + shadow_off_x, y_top + shadow_off_y), (v_mid_x + shadow_off_x, y_bot + shadow_off_y), STROKE_W, shadow_color)
    draw_rounded_stroke(s_draw, (v_mid_x + shadow_off_x, y_bot + shadow_off_y), (v_right_x + shadow_off_x, y_top + shadow_off_y), STROKE_W, shadow_color)

    shadow_img = shadow_img.filter(ImageFilter.GaussianBlur(radius=40))
    fg_img = Image.alpha_composite(fg_img, shadow_img)

    # B) Monogram Vector Strokes Layer
    strokes_img = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    st_draw = ImageDraw.Draw(strokes_img)

    # Draw "M" in Crisp White (#FFFFFF)
    draw_rounded_stroke(st_draw, (m_left_x, y_bot), (m_left_x, y_top), STROKE_W, COLOR_WHITE)
    draw_rounded_stroke(st_draw, (m_left_x, y_top), (m_mid_x, y_mid), STROKE_W, COLOR_WHITE)
    draw_rounded_stroke(st_draw, (m_mid_x, y_mid), (m_right_x, y_top), STROKE_W, COLOR_WHITE)
    draw_rounded_stroke(st_draw, (m_right_x, y_top), (m_right_x, y_bot), STROKE_W, COLOR_WHITE)

    # Draw "V" in Warm Coral Accent (#E85D4A)
    draw_rounded_stroke(st_draw, (v_left_x, y_top), (v_mid_x, y_bot), STROKE_W, COLOR_PRIMARY)
    draw_rounded_stroke(st_draw, (v_mid_x, y_bot), (v_right_x, y_top), STROKE_W, COLOR_PRIMARY)

    fg_img = Image.alpha_composite(fg_img, strokes_img)

    # -------------------------------------------------------------
    # 3. Resample to 1024x1024 with LANCZOS
    # -------------------------------------------------------------
    fg_1024 = fg_img.resize((1024, 1024), Image.Resampling.LANCZOS)
    bg_1024 = bg_img.resize((1024, 1024), Image.Resampling.LANCZOS)

    full_icon_1024 = Image.alpha_composite(bg_1024, fg_1024)

    output_dir = "assets/images"
    os.makedirs(output_dir, exist_ok=True)

    icon_path = os.path.join(output_dir, "app_icon.png")
    fg_path = os.path.join(output_dir, "app_icon_foreground.png")

    full_icon_1024.save(icon_path, "PNG")
    fg_1024.save(fg_path, "PNG")

    print(f"Generated {icon_path} (1024x1024)")
    print(f"Generated {fg_path} (1024x1024)")

if __name__ == "__main__":
    create_app_icons()
