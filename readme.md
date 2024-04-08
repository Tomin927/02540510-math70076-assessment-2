# **Project Objective**

------------------------------------------------------------------------

The goal of this project is to model a complex dataset using in-depth statistical analysis and identify the key factors of popular tracks. The dataset is available on [Kaggle](https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset?resource=download), and it includes information about 125 different genres of Spotify tracks.

# **Dataset**

------------------------------------------------------------------------

The `dataset.csv` contains the track information on Spotify for 125 different genres. A regression model is fitted to the dataset to assess the relationship between the popularity of a track ('***popularity***') in a scale of 0 \~ 100, with 100 being the most popular, and the following variates:

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

The `dataset.csv` is recorded as following:

|                  |                             |                    |                     |                |                    |                 |
|------------------|-----------------------------|--------------------|---------------------|----------------|--------------------|-----------------|
| **\#**           | **track_id**                | **artists**        | **album_name**      | **track_name** | **popularity**     | **duration_ms** |
| *int.*           | *str.*                      | *str.*             | *str.*              | *str.*         | *num.*             | *num.*          |
| 0 \~ 113999      | e.g. 2hETkH7cOfqmz3LqZDHZf5 | e.g. Cesária Evora | e.g. Miss Perfumado | e.g. Barbincor | 0 \~ 100           | e.g. 241826     |
| **explicit**     | **danceability**            | **energy**         | **key**             | **loudness**   | **mode**           | **speechiness** |
| *bool.*          | *num.*                      | *num.*             | *int.*              | *num.*         | *int.*             | *num.*          |
| True / False     | 0 \~ 1                      | 0 \~ 1             | 0 \~ 11             | e.g. -18.515   | 0, 1               | 0 \~ 1          |
| **acousticness** | **instrumentalness**        | **liveness**       | **valence**         | **tempo**      | **time_signature** | **track_genre** |
| *num.*           | *num.*                      | *num.*             | *num.*              | *num.*         | *int.*             | *str.*          |
| 0 \~ 1           | 0 \~ 1                      | 0 \~ 1             | 0 \~ 1              | e.g. 181.74    | 0 \~ 5             | e.g. ambient    |

The data analysis file is `statistical_analysis.R`.
