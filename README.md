# MovieExplorer
A lightweight **Movie Browser App** built with **SwiftUI**, **Async/Await networking**, and a clean **MVVM architecture**.  

It fetches movies from [The Movie Database (TMDb) API](https://developer.themoviedb.org/) and demonstrates **networking, caching, dependency injection, and search** in a production-ready SwiftUI app.

---

## ✨ Features
- ✅ Fetches **Popular Movies** from TMDb using `URLSession` + async/await  
- ✅ **MVVM Architecture** with clear separation of concerns  
- ✅ **Offline Caching** for movies (`CacheService` with JSON persistence)  
- ✅ **Image Caching** in memory + disk (`NSCache` + file-based storage)  
- ✅ **Search** with debouncing behavior (min. 3 chars required)  
- ✅ **SwiftUI UI Layer** with `NavigationStack`, `searchable`, and pull-to-refresh  
- ✅ **Error Handling** with fallback to cached data when network fails  

---

## 🛠️ Tech Stack & Reasoning

### 1. **Swift Concurrency (`async/await`)**
- Simplifies networking with `URLSession`.
- Avoids callback hell and integrates naturally with SwiftUI’s `.task {}` modifier.

### 2. **MVVM Architecture**
- `MovieListViewModel`: Handles UI state, networking, caching, and search.
- `MovieRepository`: Acts as a **bridge** between data sources (Network + Cache).
- `NetworkService`: Isolated network layer that can be swapped/mocked.
- `CacheService`: Encapsulates offline persistence.

> **Reasoning**: Keeping networking, caching, and business logic separate makes the app testable, scalable, and easier to extend (e.g., adding "Top Rated" movies).

### 3. **Dependency Injection via Protocols**
- `NetworkServicingProtocol`, `CacheServicingProtocol`, and `MovieRepositoryProtocol`.
- Improves **testability** (e.g., mock repositories for unit tests).
- Keeps components **decoupled**.

### 4. **Caching**
- **Movies Cache** → Stored as JSON in Documents directory (`CacheService`).
- **Image Cache** → Dual-layer caching:
  - In-memory (`NSCache`) for fast retrieval.
  - Disk (`FileManager`) for persistence across launches.

### 5. **Search**
- Handled inside `MovieListViewModel`.
- Optimized: Only applies search if input ≥ 3 characters.

---

## 🚀 Getting Started

### Prerequisites
- macOS **13.0+**
- Xcode **15.0+**
- iOS **17.0+** (deployment target adjustable)
- A valid **TMDb API Key** ([get one here](https://developer.themoviedb.org/))
