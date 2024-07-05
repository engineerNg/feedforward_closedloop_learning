import torch
import torch.nn as nn
import torch.optim as optim

# 定义一个简单的前馈神经网络
class SimpleNN(nn.Module):
    def __init__(self, input_size, hidden_size, output_size):
        super(SimpleNN, self).__init__()
        self.fc1 = nn.Linear(input_size, hidden_size)
        self.relu = nn.ReLU()
        self.fc2 = nn.Linear(hidden_size, output_size)

    def forward(self, x):
        out = self.fc1(x)
        out = self.relu(out)
        out = self.fc2(out)
        return out

# 创建网络实例
input_size = 2  # 传感器数据和当前误差
hidden_size = 10
output_size = 1  # 预测的误差
model = SimpleNN(input_size, hidden_size, output_size)

# 损失函数和优化器
criterion = nn.MSELoss()
optimizer = optim.Adam(model.parameters(), lr=0.01)

# 模拟训练数据
# x_data: 传感器数据和当前误差
# y_data: 预测的下一个时间步的误差
x_data = torch.tensor([[0.5, 0.1], [0.6, 0.2], [0.4, 0.15], [0.3, 0.05]], dtype=torch.float32)
y_data = torch.tensor([[0.7], [0.8], [0.6], [0.5]], dtype=torch.float32)

# 训练过程
num_epochs = 100
for epoch in range(num_epochs):
    model.train()
    outputs = model(x_data)
    loss = criterion(outputs, y_data)

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    if (epoch+1) % 10 == 0:
        print(f'Epoch [{epoch+1}/{num_epochs}], Loss: {loss.item():.4f}')

# 模拟测试
model.eval()
test_data = torch.tensor([[0.55, 0.12]], dtype=torch.float32)
predicted = model(test_data)
print(f'Predicted error for next time step: {predicted.item():.4f}')
