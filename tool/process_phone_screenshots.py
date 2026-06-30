#!/usr/bin/env python3
"""Crop native phone screenshots to Play Store 9:16 (min side >= 1080)."""

from __future__ import annotations

import sys
from pathlib import Path

from PIL import Image


def to_play_store_9_16(img: Image.Image) -> Image.Image:
    img = img.convert("RGB")
    w, h = img.size
    target_h = round(w * 16 / 9)
    if target_h <= h:
        y0 = (h - target_h) // 2
        return img.crop((0, y0, w, y0 + target_h))
    target_w = round(h * 9 / 16)
    x0 = (w - target_w) // 2
    return img.crop((x0, 0, x0 + target_w, h))


def main() -> None:
    if len(sys.argv) != 3:
        print("Usage: process_phone_screenshots.py <input_dir> <output_dir>")
        sys.exit(1)

    src_dir = Path(sys.argv[1])
    out_dir = Path(sys.argv[2])
    out_dir.mkdir(parents=True, exist_ok=True)

    if not src_dir.exists():
        print(f"No screenshots found at {src_dir}")
        sys.exit(0)

    for src in sorted(src_dir.glob("*.png")):
        img = Image.open(src)
        out = to_play_store_9_16(img)
        # Upscale to 1080w if smaller (Play Store min 320, recommended 1080+)
        w, h = out.size
        if w < 1080:
            scale = 1080 / w
            out = out.resize((1080, round(h * scale)), Image.Resampling.LANCZOS)
        dest = out_dir / src.name
        out.save(dest, "PNG", optimize=True)
        print(f"{src.name} -> {dest.name} ({out.size[0]}x{out.size[1]})")


if __name__ == "__main__":
    main()
