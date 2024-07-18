# import numpy as np
# from sklearn.linear_model import LinearRegression
# import matplotlib.pyplot as plt

# data = np.loadtxt('/home/kinsley/OneDrive/study/final_project/feedforward_closedloop_learning/linefollower/layer0.dat')
# first_row = data[0, :150]

# X = np.arange(1, len(first_row) + 1).reshape(-1, 1)  
# y = first_row.reshape(-1, 1)  

# model = LinearRegression()

# model.fit(X, y)

# print(f"Slope (Coefficient): {model.coef_[0][0]}")
# print(f"Intercept: {model.intercept_[0]}")

# y_pred = model.predict(X)

# plt.scatter(X, y, color='blue', label='Data points')
# plt.plot(X, y_pred, color='red', label='Linear regression line')
# plt.xlabel('X')
# plt.ylabel('y')
# plt.title('Linear Regression')
# plt.legend()
# plt.show()

import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt
import matplotlib
import time

matplotlib.use('gtk3agg')

# 确保路径正确，文件名正
file_path = '/home/kinsley/github_project/feedforward_closedloop_learning/linefollower/layer0.dat'  # 替换为你的实际文件路径

# 创建一个绘图窗口
plt.ion()
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8))

# 存储 y=0 时的 x 值
x_at_y_zero_values = []

try:
    while True:
        # 读取数据文件，只提取第一行
        data = np.loadtxt(file_path)
        first_row = data[11, :]  # 提取第一行的前 150 个数据

        # 创建 X 和 y
        X = np.arange(1, len(first_row) + 1).reshape(-1, 1)  # 横坐标 1 到 150
        y = first_row.reshape(-1, 1)  # 纵坐标是对应的值

        # 创建线性回归模型
        model = LinearRegression()

        # 拟合模型
        model.fit(X, y)

        # 输出回归系数和截距
        slope = model.coef_[0][0]
        intercept = model.intercept_[0]
        print(f"Slope (Coefficient): {slope}")
        print(f"Intercept: {intercept}")

        # 计算 y=0 时的 x 值
        if slope != 0:
            x_at_y_zero = -intercept / slope
            print(f"x at y=0: {x_at_y_zero}")
        else:
            x_at_y_zero = np.nan
            print("Slope is zero, cannot determine x at y=0")

        # 记录 x_at_y_zero 值
        x_at_y_zero_values.append(x_at_y_zero)

        # 使用模型进行预测
        y_pred = model.predict(X)

        # 清除旧图像并绘制新图像
        ax1.clear()
        ax1.scatter(X, y, color='blue', label='Data points')
        ax1.plot(X, y_pred, color='red', label='Linear regression line')
        ax1.axhline(0, color='gray', linewidth=0.5)
        ax1.axvline(x_at_y_zero, color='green', linestyle='--', label=f'x at y=0: {x_at_y_zero:.2f}')
        ax1.set_xlabel('X')
        ax1.set_ylabel('y')
        ax1.set_title('Linear Regression')
        ax1.legend()

        # 绘制 x_at_y_zero_values 的折线图
        ax2.clear()
        ax2.plot(x_at_y_zero_values, color='blue', label='x at y=0 over time')
        ax2.set_xlabel('Time (5s intervals)')
        ax2.set_ylabel('x at y=0')
        ax2.set_title('x at y=0 Over Time')
        ax2.legend()

        # 更新图像
        plt.draw()
        plt.pause(0.01)

        # 等待5秒
        time.sleep(5)

except FileNotFoundError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"An error occurred: {e}")
