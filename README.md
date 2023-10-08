# flutter_pixabay_api_search_app

## Problem Definition

Develop a single-view app that allows the user to search images through Pixabay services.

### Requirements

- UI, UX should be as similar as possible as the [video](./sample.mov) provided

```
./sample.mov
```

- You can use third-party libraries
- Display first 50 photos returned
- No pagination required
- Should be able to type ahead to perform searches after 3 characters

### Instructions

Implement the above by completing the items below (noted as TODO items in the relevant dart files):

1. Implement the requestPictures method in the pixabay_service.dart
2. Implement the PixabayResultsModel.fromMap function in the pixabay_data_model.dart
3. Implement the PixabayMediaModel.fromMap function in pixabay_data_model.dart
4. Implement the UI for displaying results in pixabay_search.dart

Bonus: Suggest improvements and simplifications to the overall project architecture.

### Interview

- Be prepared to explain your code during the interview

### Notes

#### API details

- Register an account at https://pixabay.com
- After registration, open https://pixabay.com/api/docs/ for API key and API documentation
