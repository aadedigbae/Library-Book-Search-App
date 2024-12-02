# Library Book Search App

## Project Overview

I developed the Library Book Search Mobile Application developed using Flutter. The app allows users to search and explore books from the Library of Congress (LOC) digital collection. The app provides an intuitive, dark-mode interface for discovering and learning about books.

## 🎯 Project Purpose

The primary goal of this application is to create a user-friendly mobile app that:
- Enables quick and efficient book searches
- Provides detailed book information
- Offers a seamless reading experience
- Demonstrates modern Flutter development practices

## 🌟 Key Features

- Dark mode interface
- Book search functionality
- Detailed book information display
- Responsive design
- Error handling
- State management with Provider

## 📡 API Selection: Library of Congress

### Why Library of Congress API?
- Free and publicly accessible
- Extensive book collection
- No authentication required
- Comprehensive book metadata

### API Endpoints Used
- Book search: `https://www.loc.gov/books/`
- Retrieves book information based on search queries

## 🖥️ Screens and Functionalities

### 1. Home Screen
- Initial entry point
- Search input field
- Search button
- Navigates to search results

### 2. Book Search Results Screen
- Displays search results
- Infinite scroll support
- Book preview cards
- Error and loading states

### 3. Book Details Screen
- Comprehensive book information
- Book cover image
- Title and author details
- Description
- Preview book button

## 🛠️ Technical Architecture

### State Management
- Provider for efficient state handling
- Separates UI from business logic

### Design Patterns
- Repository pattern for API interactions
- Dependency injection
- Separation of concerns

## 🧩 Critical Components

### Models
- `BookModel`: Represents book data structure
- Flexible JSON parsing
- Handles various API response formats

### Services
- `LibraryApiService`: Manages API interactions
- Error handling
- Data transformation

### Providers
- `BookSearchProvider`: Manages search state
- Handles loading, error, and data states

## 🚧 Development Challenges and Solutions

### 1. API Response Parsing
**Challenge**: Inconsistent JSON structures
**Solution**: 
- Implemented robust parsing methods
- Added fallback values
- Created flexible data extraction logic

### 2. Error Handling
**Challenge**: Managing different error scenarios
**Solution**:
- Comprehensive error handling
- User-friendly error messages
- Intuitive error state management

### 3. Dark Mode Implementation
**Challenge**: Consistent dark theme across screens
**Solution**:
- Centralized theme configuration
- Adaptive color schemes
- Consistent typography

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart
- Android Studio / VS Code
- Internet connection

### Installation Steps
1. Clone the repository
```bash
git clone https://github.com/yourusername/library-book-search.git

2. Install dependencies
fl

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
