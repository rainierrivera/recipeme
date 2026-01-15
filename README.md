# recipeme
RecipeApp – Project Structure

This project is built using SwiftUI and targets Xcode 26.2, following a modular MVVM + Coordinator architecture.
It emphasizes clean separation of concerns, testability via dependency injection, and flexibility between real API requests and local mock data.

⸻

🧱 Technology Stack
  •  SwiftUI
  •  Xcode 26.2
  •  MVVM Architecture
  •  Coordinator Pattern
  •  Dependency Injection
  •  Local JSON Mocking for Development

📁 Project Structure Overview

Test
├── Coordinator
├── Model
│   ├── NetworkModel
│   ├── Category
│   ├── Ingredient
│   ├── IngredientCategory
│   ├── IngredientDisplayItem
│   ├── PopularRecipeItem
│   ├── Recipe
│   ├── RecipePayload
│   └── RecipeStep
├── Preview Content
├── RecipeApp
│   ├── Network
│   ├── Service
│   ├── View
│   └── ViewModel
├── Assets
├── recipes.json
├── AppSearchTextField
├── SearchBar
├── SearchField
├── SearchItemView
├── SearchListViewModel
├── SearchView
├── SearchViewModel
├── TestTests
└── TestUITests



🧭 Coordinator

Coordinator/
  •  Centralizes navigation logic
  •  Keeps navigation out of views and view models
  •  Makes screen flow predictable and scalable
  •  Enables easier refactoring as the app grows

⸻

📦 Model Layer

Model/

Contains all domain and data models used across the app:
  •  Core models:
Recipe, RecipeStep, Ingredient
  •  Classification models:
Category, IngredientCategory
  •  UI display helpers:
IngredientDisplayItem, PopularRecipeItem
  •  Network payloads:
RecipePayload

All models are designed to be:
  •  Codable / Decodable
  •  Compatible with both real API responses and local JSON



⸻

🌐 Network Layer

RecipeApp/Network/
  •  Designed for real-time API requests
  •  Supports:
  •  Configurable endpoints
  •  Query parameters
  •  Headers
  •  Abstracted via protocols to support swapping implementations

🧪 Mock Network Support

Although the network layer is production-ready, the project includes:
  •  MockNetworkService
  •  Reads from recipes.json
  •  Enables:
  •  Offline development
  •  Predictable data
  •  Faster UI iteration without backend dependency

The mock and real network services are interchangeable via dependency injection.


⸻

🧰 Service Layer

RecipeApp/Service/
  •  Handles business logic
  •  Orchestrates data between Network and ViewModels
  •  Keeps ViewModels lightweight and focused on presentation logic

⸻

🖼 View Layer

RecipeApp/View/

Contains all SwiftUI views:
  •  Recipe lists and detail screens
  •  Search and filtering UI
  •  Reusable components:
  •  Recipe cards
  •  Ingredient cards
  •  Search fields

Views are:
  •  Stateless
  •  Driven entirely by ViewModels
  •  Easy to preview and reuse

⸻


⸻

🧠 ViewModel Layer

RecipeApp/ViewModel/
  •  Implements MVVM pattern
  •  Manages:
  •  UI state
  •  Search logic
  •  Filtering and grouping
  •  User interactions
  •  Communicates only with Services / Network abstractions

Testability
  •  ViewModels and data objects are fully testable
  •  All dependencies are injected
  •  No hard coupling to concrete network implementations

⸻
🔍 Search Components

Reusable SwiftUI components:
  •  AppSearchTextField
  •  SearchBar
  •  SearchField
  •  SearchItemView

Designed for reuse across multiple screens.

⸻

🧪 Testing

Current Status
  •  ❌ Unit tests are not yet implemented
  •  Test targets already exist:
  •  TestTests
  •  TestUITests

Architecture Readiness

Even though tests are not yet written:
  •  Models are isolated
  •  ViewModels use dependency injection
  •  Network layer is mockable

This makes the codebase ready for unit testing when added.

⸻


📌 Summary
  •  ✅ Built with SwiftUI (Xcode 26.2)
  •  ✅ MVVM + Coordinator architecture
  •  ✅ Real network layer with mock JSON fallback
  •  ✅ Dependency-injected, testable design
  •  ⏳ Unit tests planned but not yet implemented

⸻


