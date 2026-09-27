# EEG-Based Emotion Recognition Using DSP and Deep Learning

## 📌 Overview

This project explores **emotion recognition using Electroencephalography (EEG) signals**. EEG provides direct information about brain activity and can be used to identify emotional states such as **valence** and **arousal**.

The project focuses on applying **Digital Signal Processing (DSP)** techniques for EEG preprocessing and feature extraction, followed by machine learning and deep learning approaches for emotion classification.

EEG signals are complex, noisy, and high-dimensional. Therefore, effective preprocessing and feature extraction are important for obtaining meaningful information from the signals.

## 🎯 Objectives

* Process and analyze EEG signals for emotion recognition.
* Remove noise and unwanted physiological artifacts.
* Extract meaningful frequency-domain features from EEG signals.
* Analyze important EEG frequency bands associated with emotions.
* Classify emotional states using machine learning/deep learning techniques.
* Explore efficient approaches suitable for real-time emotion recognition.

## 🧠 Emotion Representation

The project primarily considers two dimensions of emotion:

* **Valence** – represents whether an emotional state is positive or negative.
* **Arousal** – represents the intensity of the emotional state, such as calm or excited.

These dimensions can be used to categorize different emotional states based on EEG activity.

## 🔄 Methodology

The overall processing pipeline consists of:

```text
EEG Signal
     │
     ▼
Signal Acquisition
     │
     ▼
Preprocessing
     │
     ├── Downsampling
     ├── Bandpass Filtering
     └── Artifact Removal
     │
     ▼
Channel Selection
     │
     ▼
Feature Extraction
     │
     └── FFT / Frequency-Domain Features
     │
     ▼
Feature Representation
     │
     ▼
ML / Deep Learning Model
     │
     ▼
Emotion Classification
     │
     ├── Valence
     └── Arousal
```

## 📊 Dataset

The project discusses the **DEAP dataset**, which contains EEG recordings from **32 subjects** who watched 40 emotion-evoking music videos.

Key characteristics include:

* **32 subjects**
* **32 EEG channels**
* Original sampling rate: **512 Hz**
* Resampled to **128 Hz**
* Binary classification of **valence and arousal**

## 🔧 Signal Preprocessing

EEG signals contain noise and unwanted physiological artifacts. The preprocessing stage therefore includes:

### Downsampling

The EEG signals are downsampled from **512 Hz to 128 Hz** to reduce redundancy and computational requirements.

### Bandpass Filtering

A **0–48 Hz bandpass filter** is applied to focus on relevant EEG frequency components and reduce unwanted frequency content.

### Artifact Removal

Unwanted components caused by baseline drift, eye movements, muscle movements, and other non-EEG sources are removed to improve signal quality.

## 📡 Channel Selection

From the available 32 EEG channels, **14 channels** are selected based on their relevance to emotional activity.

The selected channels generally cover regions including:

* Frontal
* Parietal
* Temporal
* Occipital regions

This reduces the dimensionality of the input while retaining important emotion-related information.

## 📈 Feature Extraction Using FFT

The **Fast Fourier Transform (FFT)** is used to convert EEG signals from the time domain into the frequency domain.

Power features are extracted from important EEG frequency bands:

| Frequency Band | Frequency Range |
| -------------- | --------------: |
| Theta          |          4–8 Hz |
| Alpha          |         8–12 Hz |
| Beta-Low       |        12–16 Hz |
| Beta-High      |        16–25 Hz |
| Gamma          |        25–45 Hz |

The extracted frequency-domain features from the selected channels are used as input to the classification model.

A window size of **32 samples** was reported as providing good performance in the discussed experiments.

## 🤖 Modified Convolutional Fuzzy Neural Network

The proposed approach uses a **Modified Convolutional Fuzzy Neural Network (CFNN)** combining convolutional neural networks with fuzzy logic.

### 1. 1D CNN

Two convolutional layers are used:

* 64 filters
* 32 filters

These layers automatically extract useful temporal and spatial features from the EEG frequency-domain data.

### 2. Max Pooling

Max-pooling reduces the feature dimensions and computational requirements while retaining important information.

### 3. Fuzzification

The extracted CNN features are passed through a fuzzy layer using **Gaussian membership functions**.

Fuzzy logic helps represent uncertainty and provides a way to handle noisy and variable EEG features.

### 4. Batch Normalization and Dense Layer

Batch normalization helps normalize the extracted features and reduce overfitting.

The dense layer provides two outputs for binary emotion classification.

### 5. Defuzzification

The fuzzy outputs are converted back into crisp values to obtain the final classification decision.

The model contains approximately **11,186 trainable parameters**, making it relatively lightweight for computationally efficient applications.

## 🧪 Comparative Models

The discussed experiments compare the proposed approach with several conventional and deep learning models:

* Support Vector Machine (SVM)
* K-Nearest Neighbors (KNN)
* Bidirectional LSTM
* 1D CNN
* Modified CFNN

## 📊 Results

For the discussed DEAP-based experiments, the Modified CFNN achieved:

| Emotion Dimension |   Accuracy |
| ----------------- | ---------: |
| Valence           | **98.21%** |
| Arousal           | **98.08%** |

The experiments also examined different FFT window sizes from **4 to 128 samples**, with window sizes of **32 and above** providing more stable results.

## 🔬 Key Findings

* EEG signals can provide useful information for emotion recognition.
* Proper preprocessing is essential because EEG signals contain significant noise and artifacts.
* Frequency-domain features extracted using FFT provide useful representations for emotion classification.
* Gamma-band information and multi-channel feature fusion are important for emotion recognition.
* Combining CNN feature extraction with fuzzy logic can help handle uncertainty and noise in EEG data.
* A lightweight architecture can be useful for computationally efficient and potentially real-time applications.

## 🛠️ Technologies & Concepts

* Python
* Digital Signal Processing (DSP)
* EEG Signal Processing
* Fast Fourier Transform (FFT)
* Convolutional Neural Networks (CNN)
* Fuzzy Neural Networks
* Machine Learning
* Deep Learning
* Signal Filtering
* Feature Extraction
* Emotion Classification

## 📂 Project Structure

```text
EEG-Based-Emotion-Recognition/
│
├── README.md
├── notebooks/
│   └── EEG_Emotion_Recognition.ipynb
│
├── dataset/
│
├── results/
│
└── figures/
```

## 🚀 Applications

EEG-based emotion recognition can have applications in:

* Human–Computer Interaction
* Affective Computing
* Healthcare
* Emotion-aware systems
* Brain–Computer Interfaces
* Real-time intelligent systems

## 🔮 Future Work

Potential future directions include:

* Multiclass emotion recognition.
* Testing the model on additional EEG datasets.
* Improving cross-subject generalization.
* Developing real-time EEG emotion recognition systems.
* Exploring domain adaptation and meta-learning techniques.
* Evaluating the approach using wearable and low-cost EEG devices.

## 📚 References

The project is based on the concepts and studies discussed in the accompanying literature review, including research on modified convolutional fuzzy neural networks, EEG-based emotion recognition, DSP-based feature extraction, and hybrid intelligent methods.

---

### 👨‍💻 Project

**EEG-Based Emotion Recognition Using DSP and Deep Learning**

This project demonstrates how **Digital Signal Processing and Artificial Intelligence** can be combined to extract meaningful information from EEG signals and recognize human emotional states.
