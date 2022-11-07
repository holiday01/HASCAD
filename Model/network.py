import torch
import torch.nn as nn
class D1(nn.Module):
    def __init__(self, gene_size, unit):
        super(D1, self).__init__()
        self.gene_size = gene_size
        self.unit = unit
        self.D1 = nn.Sequential(
            nn.Linear(self.gene_size, 1024),
            nn.ReLU(),
            nn.Linear(1024, 256),
            nn.ReLU(),
            nn.Linear(256, 64),
            nn.ReLU(),
            nn.Linear(64, self.unit),
            nn.Softmax(dim=1),
        )


    def forward(self, inputs):
        out = self.D1(inputs)
        return out

class D2(nn.Module):
    def __init__(self, gene_size, unit):
        super(D2, self).__init__()
        self.gene_size = gene_size
        self.unit = unit

        self.D2 = nn.Sequential(
            nn.Linear(self.gene_size, 512),
            nn.ReLU(),
            nn.Linear(512, 128),
            nn.ReLU(),
            nn.Linear(128, 32),
            nn.ReLU(),
            nn.Linear(32, self.unit),
            nn.Softmax(dim=1),
        )


    def forward(self, inputs):
        out = self.D2(inputs)
        return out

class D3(nn.Module):
    def __init__(self, gene_size, unit):
        super(D3, self).__init__()
        self.gene_size = gene_size
        self.unit = unit

        self.D3 = nn.Sequential(
            nn.Linear(self.gene_size, 256),
            nn.ReLU(),
            nn.Linear(256, 64),
            nn.ReLU(),
            nn.Linear(64, 32),
            nn.ReLU(),
            nn.Linear(32, self.unit),
            nn.Softmax(dim=1),
        )


    def forward(self, inputs):
        out = self.D3(inputs)
        return out
