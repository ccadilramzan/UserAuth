♦︎ User Authentication using shared preferences and UiKit (SwiftUi & Swift)
♦︎ clean, scalable folder and file structure following MVVM and SOLID principles

/UserAuth
 ├── /Model
 │    ├── User.swift                  // User model entity
 │    └── UserCache.swift             // Handles local cache & UserDefaults logic
 │
 ├── /View
 │    ├── LoginViewController.swift   // Login screen UI + bindings
 │    ├── SignupViewController.swift  // Signup screen UI + bindings
 │    └── CustomUIComponents.swift    // Any reusable UI components
 │
 ├── /ViewModel
 │    ├── LoginViewModel.swift        // Logic for Login
 │    ├── SignupViewModel.swift       // Logic for Signup
 │    └── UserSessionViewModel.swift  // For shared user session state, if needed
 │
 ├── /Services
 │    └── UserService.swift           // Business logic for user signup/login (e.g., validation)
 │
 ├── /Utils
 │    └── Extensions.swift            // Helpful extensions for UserDefaults, String, etc.
 │
 └── /Resources
      └── Assets.xcassets             // Images, icons, etc.
