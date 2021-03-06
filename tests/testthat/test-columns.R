context("Makes correct dummy columns")

load(system.file("testdata", "fastDummies_data.rda",
                 package = "fastDummies"))
most_frequent <- data.frame(animal = c("dog", "cat", "cat",
                                       "gorilla", "gorilla",
                                       "gorilla"),
                            day    = c("monday", "tuesday",
                                       "wednesday", "wednesday",
                                       "friday", "saturday"),
                            hour = 1:6)


test_that("The correct dummy columns are made - default", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE]),
               c("gender", "gender_male", "gender_female"))

  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals", "animals_dog", "animals_cat"))

  expect_named(dummy_cols(fastDummies_example),
               c("numbers", "gender", "animals",
                 "dates", "gender_male", "gender_female",
                 "animals_dog", "animals_cat"))

  expect_named(dummy_cols(fastDummies_example[, "numbers", drop = FALSE]),
               c("numbers", "numbers_1", "numbers_2", "numbers_3"))


})


test_that("The correct dummy columns are made - select_columns", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          select_columns = "gender"),
               c("gender", "gender_male", "gender_female"))



  expect_named(dummy_cols(fastDummies_example, select_columns = "numbers"),
               c("numbers", "gender", "animals", "dates",
                 "numbers_1", "numbers_2", "numbers_3"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE]),
               c("animals", "animals_dog", "animals_cat"))

  # animal first in select_columns
  expect_named(dummy_cols(fastDummies_example, select_columns = c("animals",
                                                                  "gender")),
               c("numbers", "gender", "animals", "dates", "animals_dog",
                 "animals_cat", "gender_male",
                 "gender_female"))
  # gender first in select_columns
  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("gender", "animals")),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female",
                 "animals_dog", "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals"),
               c("numbers", "gender", "animals", "dates", "animals_dog",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender"),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female"))

  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("gender", "numbers")),
               c("numbers", "gender", "animals", "dates", "gender_male",
                 "gender_female", "numbers_1", "numbers_2", "numbers_3"))

})


test_that("Remove first dummy leads to proper dummy columns being made", {
  expect_named(dummy_cols(fastDummies_example[, "gender", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("gender", "gender_female"))

  expect_named(dummy_cols(fastDummies_example[, "numbers", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("numbers", "numbers_2", "numbers_3"))


  expect_named(dummy_cols(fastDummies_example[, "animals", drop = FALSE],
                          remove_first_dummy = TRUE),
               c("animals", "animals_cat"))



  expect_named(dummy_cols(fastDummies_example, remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates", "gender_female",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = c("gender",
                                                                  "animals"),
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates", "gender_female",
                 "animals_cat"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "gender",
                          remove_first_dummy = TRUE),
               c("numbers", "gender",  "animals", "dates", "gender_female"))
  expect_named(dummy_cols(fastDummies_example, select_columns = "animals",
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates",
                 "animals_cat"))

  expect_named(dummy_cols(fastDummies_example, select_columns = "numbers",
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates",
                 "numbers_2", "numbers_3"))
  expect_named(dummy_cols(fastDummies_example,
                          select_columns = c("animals", "numbers"),
                          remove_first_dummy = TRUE),
               c("numbers", "gender", "animals", "dates",
                 "animals_cat", "numbers_2", "numbers_3"))
})

test_that("remove_most_frequent_dummy works", {
expect_named(dummy_cols(most_frequent, remove_most_frequent_dummy = TRUE),
             c("animal", "day", "hour", "animal_dog",
               "animal_cat",
               "day_monday", "day_tuesday",
                "day_friday",
               "day_saturday"))
expect_named(dummy_cols(most_frequent, select_columns = c("animal", "day"),
                        remove_most_frequent_dummy = TRUE),
             c("animal", "day", "hour", "animal_dog",
               "animal_cat",
               "day_monday", "day_tuesday",
                "day_friday",
               "day_saturday"))
expect_named(dummy_cols(most_frequent, select_columns = "animal",
                        remove_most_frequent_dummy = TRUE),
             c("animal", "day", "hour", "animal_dog",
               "animal_cat"))
expect_named(dummy_cols(most_frequent, select_columns = "day",
                        remove_most_frequent_dummy = TRUE),
             c("animal", "day", "hour",
               "day_monday", "day_tuesday",
               "day_friday",
               "day_saturday"))
expect_named(dummy_cols(most_frequent, select_columns = "hour",
                        remove_most_frequent_dummy = TRUE),
             c("animal", "day", "hour",
               "hour_2", "hour_3",
               "hour_4", "hour_5",
               "hour_6"))

})
