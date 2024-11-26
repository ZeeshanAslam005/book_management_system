Swagger::Docs::Config.register_apis({
  "1.0" => {
    api_extension_type: :json,
    api_file_path: "public/api-docs",
    base_path: "http://localhost:3000", # Change for production
    clean_directory: true,
    attributes: {
      info: {
        title: "Bookstore Management API",
        description: "API documentation for Bookstore and Book endpoints",
        termsOfServiceUrl: "https://example.com/terms",
        contact: "support@example.com",
        license: "Apache 2.0",
        licenseUrl: "http://www.apache.org/licenses/LICENSE-2.0.html"
      }
    }
  }
})
