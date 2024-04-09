# **Project Objective**

------------------------------------------------------------------------

The goal of this project is to model a complex dataset using in-depth statistical analysis and identify the key factors of popular tracks. The dataset is available on [Kaggle](https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset?resource=download), and it includes information about 125 different genres of Spotify tracks.

# **Dataset**

------------------------------------------------------------------------

The `dataset.csv` contains the track information on Spotify for 125 different genres. A regression model is fitted to the dataset to assess the relationship between the popularity of a track ('***popularity***') in a scale of 0 \~ 100, with 100 being the most popular, and the following variates of interested:

-   ***duration_ms***: The track length in milliseconds.

-   ***danceability***: *Danceability* describes how suitable a track is for dancing based on a combination of musical elements including *tempo, rhythm stability, beat strength,* and overall *regularity*. (A value of 0.0 is least danceable and 1.0 is most danceable)

-   ***energy***: *Energy* is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. (An energetic tracks feel fast, loud, and noisy)

-   **key**: The *key* of a track is an integers (-1 \~ 11) map to pitches using standard Pitch Class notation. (`0 = C`, `1 = C♯/D♭`, `2 = D`, and so on; If no key was detected, the value is -1)

-   **loudness**: The overall *loudness* of a track in decibels (dB).

-   **mode**: *Mode* indicates the modality (major = 1 or minor = 0) of a track.

-   **speechiness**: *Speechiness* detects the presence of spoken words in a track.

    -   The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value.

    -   Values above 0.66 describe tracks that are probably made entirely of spoken words.

    -   Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music.

    -   Values below 0.33 most likely represent music and other non-speech-like tracks

-   **acousticness**: A confidence measure from 0.0 to 1.0 of whether the track is *acoustic*. (1.0 represents high confidence the track is acoustic)

-   **instrumentalness**: Predicts whether a track contains *no* *vocals*. (The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content)

-   **liveness**: Detects the *presence of an audience* in the recording. Higher liveness values represent an increased probability that the track was performed live. (A value above 0.8 provides strong likelihood that the track is live)

-   **valence**: A measure from 0.0 to 1.0 describing the musical *positiveness* conveyed by a track. Tracks with high valence sound more positive. (e.g. happy, cheerful, euphoric)

-   **tempo**: The overall estimated *tempo* of a track in beats per minute (BPM).

-   **time_signature**: The *time signature* (meter) is a notational convention to specify how many beats are in each bar (or measure). (A ranges from 3 to 7 indicating time signatures of `3/4`, to `7/4`)

-   **track_genre**: The *genre* in which the track belongs.

The data analysis file is `statistical_analysis.R`.

# **Data Exploration**

------------------------------------------------------------------------

## The summary of numerical variables

| Variable            | Mean    | Variance    | Min-Median-Max           | 1st Qu. - 3rd Qu. |
|---------------|---------------|---------------|---------------|---------------|
| Popularity (Target) | 33.24   | 22.31\^2    | 0 - 35 - 100             | 17 - 50           |
| 1 duration_ms       | 228029  | 107297.7\^2 | 0 - 212906 -5237295      | 174066 - 261506   |
| 2 danceability      | 0.5668  | 0.17\^2     | 0 - 0.58 - 0.985         | 0.456 - 0.695     |
| 3 energy            | 0.6414  | 0.25\^2     | 0 - 0.685 - 1            | 0.472 - 0.854     |
| 4 key               | 5.309   | 3.56\^2     | 0 - 5 - 11               | 2 - 8             |
| 5 loudness          | -8.259  | 5.03\^2     | -49.531 - -7.004 - 4.532 | -10.013 - -5.003  |
| 6 mode              | 0.6376  | 0.48\^2     | 0 - 1 - 1                | 0 - 1             |
| 7 speechiness       | 0.08465 | 0.11\^2     | 0 - 0.0489 - 0.965       | 0.0359 - 0.0845   |
| 8 acousticness      | 0.3149  | 0.33\^2     | 0 - 0.169 - 0.996        | 0.0169 - 0.5980   |
| 9 instrumentalness  | 0.156   | 0.31\^2     | 0 - 4.16e-5 - 1          | 0 - 0.049         |
| 10 liveness         | 0.2136  | 0.19\^2     | 0 - 0.132 - 1            | 0.098 - 0.273     |
| 11 valence          | 0.4741  | 0.26\^2     | 0 - 0.464 - 0.995        | 0.26 - 0.683      |
| 12 tempo            | 122.15  | 29.98\^2    | 0 - 122.02 - 243.37      | 99.22 - 140.07    |
| 13 time_signature   | 3.904   | 0.43\^2     | 0 - 4 - 5                | 4 - 4             |
