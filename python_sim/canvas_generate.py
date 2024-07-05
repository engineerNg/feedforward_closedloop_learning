import numpy as np
import matplotlib.pyplot as plt
import cv2
from scipy.ndimage import binary_fill_holes

def generate_track():
    # 创建一个空白图像
    track_image = np.ones((500, 500), dtype=np.uint8) * 255

    # 定义赛道参数
    center = [250, 250]
    outer_radius = 200
    inner_radius = 100
    num_points = 100

    # 生成赛道外圈
    theta = np.linspace(0, 2 * np.pi, num_points)
    outer_x = center[0] + outer_radius * np.cos(theta)
    outer_y = center[1] + outer_radius * np.sin(theta)

    # 生成赛道内圈
    inner_x = center[0] + inner_radius * np.cos(theta)
    inner_y = center[1] + inner_radius * np.sin(theta)

    # 创建赛道外圈
    for i in range(num_points-1):
        cv2.line(track_image, (int(outer_x[i]), int(outer_y[i])), (int(outer_x[i+1]), int(outer_y[i+1])), 0, 5)
        cv2.line(track_image, (int(inner_x[i]), int(inner_y[i])), (int(inner_x[i+1]), int(inner_y[i+1])), 0, 5)

    # 使用二值图像填充赛道内部
    mask = np.zeros_like(track_image)
    cv2.fillPoly(mask, [np.array([np.c_[outer_x, outer_y].astype(np.int32)])], 1)
    cv2.fillPoly(mask, [np.array([np.c_[inner_x, inner_y].astype(np.int32)])], 0)
    track_image[mask == 1] = 0

    # 保存图像
    plt.imshow(track_image, cmap='gray')
    plt.axis('off')
    plt.savefig('./track.png', bbox_inches='tight', pad_inches=0)
    plt.close()

generate_track()
