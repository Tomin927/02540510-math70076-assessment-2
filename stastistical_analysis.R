## =============================================================================
## Explore the dataset
## =============================================================================

# Scatterplot of all the explanatory and response variable
#    response variable - popularity (integer, range 0 ~ 100)
#    explanatory variable
#        x1 -   duration_ms     (integer)
#        x2 -   danceability    (float)
#        x3 -   energy          (float)
#        x4 -   key             (integer)
#        x5 -   loudness        (float)
#        x6 -   mode            (integer)
#        x7 -   speechiness     (float)
#        x8 -   acousticness    (float)
#        x9 -   instrumentalness(float)
#        x10 -  liveness        (float)
#        x11 -  valence         (float)
#        x12 -  tempo           (float)
#        x13 -  time_signature  (integer)


## Create the DataFrame
library(readr)
dataset <- read_csv("dataset.csv")

explanatory <- c('duration_ms', 'danceability', 'energy', 'key', 'loudness',
                 'mode', 'speechiness', 'acousticness', 'instrumentalness',
                 'liveness', 'valence', 'tempo', 'time_signature')
df <- dataset[,c('popularity', explanatory)]

## Summary of dataset
summary(df)

## Plot the distribution of target variable
library(ggplot2)
library(ggpubr)
theme_set(theme_pubr())

gy1 <- ggplot(df, aes(x=popularity)) +
  geom_histogram(color="black", fill="white")

gy2 <- ggplot(df, aes(x=popularity, color= (popularity>=60))) +
  geom_histogram(fill="white", alpha=0.5, position="identity")

ggarrange(gy1, gy2, ncol = 2, nrow = 1)


## Plot of explanatory variables vs popularity
g1 <- ggplot(df, aes(x = danceability, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Danceability", y = "Popularity") +
  theme(legend.position="none")

g2 <- ggplot(df, aes(x = energy, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Energy") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

g3 <- ggplot(df, aes(x = loudness, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Loudness") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

g4 <- ggplot(df, aes(x = speechiness, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Speechiness", y = "Popularity") +
  theme(legend.position="none")

g5 <- ggplot(df, aes(x = acousticness, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Acousticness") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

g6 <- ggplot(df, aes(x = instrumentalness, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Instrumentalness") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

g7 <- ggplot(df, aes(x = liveness, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Liveness", y = "Popularity") +
  theme(legend.position="none")

g8 <- ggplot(df, aes(x = valence, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Valence") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

g9 <- ggplot(df, aes(x = tempo, y = popularity, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Tempo") +
  theme(axis.text.y=element_blank(),  axis.title.y=element_blank(),
        legend.position="none")

ggarrange(g1, g2, g3, ncol = 3, nrow = 1)
ggarrange(g4, g5, g6, ncol = 3, nrow = 1)
ggarrange(g7, g8, g9, ncol = 3, nrow = 1)


## Plot of explanatory variables vs explanatory variables
g12 <- ggplot(df, aes(x = danceability, y = energy, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Danceability", y = "Energy") +
  theme(legend.position="none")

g23 <- ggplot(df, aes(x = energy, y = loudness, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Energy", y = "Loudness") +
  theme(legend.position="none")

g15 <- ggplot(df, aes(x = danceability, y = acousticness, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Danceability", y = "Acousticness") +
  theme(legend.position="none")

g19 <- ggplot(df, aes(x = danceability, y = tempo, color = (popularity>=60))) +
  geom_point() +
  labs(x = "Danceability", y = 'tempo') +
  theme(legend.position="none")

ggarrange(g12, g23, g15, g19, ncol = 2, nrow = 2)


## Covariance plot for explainatory variables
library(reshape)

m <- melt(round(cor(df[,explanatory]),2))

ggplot(m, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile(color = "black") +
  geom_text(aes(label = value), color = "white", size = 2) +
  coord_fixed() +
  theme(axis.text.x=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank())


## =============================================================================
## Preprocess dataset
## =============================================================================

#  remove rows with popularity = 0
df <- subset(df, popularity > 0)

#  remove rows with missing values
df <- na.omit(df)
n <- nrow(df) # count the number of records

#  70/30 train-test split
my_cid = 2540510
set.seed(my_cid)

train_idx <- sample(n, size = 0.7*n)
df_train <- df[train_idx, ]
df_test <- df[-train_idx, ]


## =============================================================================
## Fit the linear regression model
## =============================================================================

attach(df_train)
model_1.lm <- lm(popularity~duration_ms+danceability+energy+key+loudness
                 +mode+speechiness+acousticness+instrumentalness
                 +liveness+valence+tempo+time_signature)
summary(model_1.lm) # Multi R2 - 0.06506

# ------------------------------------------------------------------------------
# Evaluate model
# ------------------------------------------------------------------------------

df_pred <- data.frame(popularity = predict(model_1.lm, df_test))

g_eval <- ggplot() +
  geom_line(data = df_test,
            aes(x = seq(1, nrow(df_test)), y = popularity, color = "true"),
            alpha = .7) +
  geom_line(data = df_pred,
            aes(x = seq(1, nrow(df_test)), y = popularity, color = "pred"),
            alpha = .8) +
  labs(x = "Tracks", y = "Popularity")
g_eval

#  accuracy within plus/minus 1 sigma interval
ggplot(df_test, aes(x = seq(1, nrow(df_test)), y = popularity,
                    color = (df_pred$popularity<popularity+sd(popularity)) &
                      (df_pred$popularity>popularity-sd(popularity)))) +
  geom_point() +
  labs(x = "Tracks", y = "Popularity")

# ------------------------------------------------------------------------------
# Assess multi-collinearity among variables
# ------------------------------------------------------------------------------
#  acousticness
acousticness.lm <- lm(acousticness~duration_ms+danceability+energy+key+loudness
                      +mode+speechiness+instrumentalness
                      +liveness+valence+tempo+time_signature)
summary(acousticness.lm)
VIF_acousticness = 1/(1-0.5751)
VIF_acousticness # 2.353495 - medium correlated (>1.5, <5)

#  loudness
loudness.lm <- lm(loudness~duration_ms+danceability+energy+key
                      +mode+speechiness+acousticness+instrumentalness
                      +liveness+valence+tempo+time_signature)
summary(loudness.lm)
VIF_loudness = 1/(1-0.6934)
VIF_loudness # 3.261579 - medium correlated (>1.5, <5)

#  energy
energy.lm <- lm(energy~duration_ms+danceability+key+loudness
                  +mode+speechiness+acousticness+instrumentalness
                  +liveness+valence+tempo+time_signature)
summary(energy.lm)
VIF_energy = 1/(1-0.7632)
VIF_energy # 4.222973 - medium correlated (>1.5, <5)

#  danceability
danceability.lm <- lm(danceability~duration_ms+energy+key+loudness
                +mode+speechiness+acousticness+instrumentalness
                +liveness+valence+tempo+time_signature)
summary(danceability.lm)
VIF_danceability = 1/(1-0.3324)
VIF_danceability # 1.497903 - low correlated (<1.5)

# ------------------------------------------------------------------------------
# Access significance of variables
# ------------------------------------------------------------------------------
#  model without 'key'
summary(lm(popularity~duration_ms+danceability+energy+loudness
           +mode+speechiness+acousticness+instrumentalness
           +liveness+valence+tempo+time_signature))

#  hypothesis test
#     H0: beta_key = 0; Ha: beta_key not 0
SSR_red = (18.57 ** 2) * 68573
SSR_full = (18.57  ** 2) * 68572
F = ((SSR_red-SSR_full) / (68573-68572)) / (18.57 ** 2) # F-statistics = 1
pf(F, 68572, 68573, lower.tail = FALSE) # p-value = 0.5 > 0.05, insignificant.

#  model without 'tempo'
summary(lm(popularity~duration_ms+danceability+key+energy+loudness
           +mode+speechiness+acousticness+instrumentalness
           +liveness+valence+time_signature))

#  hypothesis test
#     H0: beta_tempo = 0; Ha: beta_tempo not 0
SSR_red = (18.57 ** 2) * 68573
SSR_full = (18.57  ** 2) * 68572
F = ((SSR_red-SSR_full) / (68573-68572)) / (18.57 ** 2) # F-statistics = 1
pf(F, 68572, 68573, lower.tail = FALSE) # p-value = 0.5 > 0.05, insignificant.

#  model without 'mode'
summary(lm(popularity~duration_ms+danceability+energy+key+loudness
           +speechiness+acousticness+instrumentalness
           +liveness+valence+tempo+time_signature))

#  hypothesis test
#     H0: beta_mode = 0; Ha: beta_mode not 0
SSR_red = (18.57 ** 2) * 68573
SSR_full = (18.57  ** 2) * 68572
F = ((SSR_red-SSR_full) / (68573-68572)) / (18.57 ** 2) # F-statistics = 1
pf(F, 68572, 68573, lower.tail = FALSE) # p-value = 0.5 > 0.05, insignificant.

#  model without 'time_signature'
summary(lm(popularity~duration_ms+danceability+energy+key+loudness
           +mode+speechiness+acousticness+instrumentalness
           +liveness+valence+tempo))

#  hypothesis test
#     H0: beta_time_signature = 0; Ha: beta_time_signature not 0
SSR_red = (18.57 ** 2) * 68573
SSR_full = (18.57  ** 2) * 68572
F = ((SSR_red-SSR_full) / (68573-68572)) / (18.57 ** 2) # F-statistics = 1
pf(F, 68572, 68573, lower.tail = FALSE) # p-value = 0.5 > 0.05, insignificant.

detach(df_train)

# ------------------------------------------------------------------------------
# Plot the distribution of variables
# ------------------------------------------------------------------------------

par(mfrow=c(4,4))
par(bg="white")
par(mar=c(2.2,2.2,2.2,2.2))

hist(as.numeric(unlist(df['popularity'])),
     main="Plot popularity")
box(lty = "solid")

for (i in 1:length(explanatory)) {
  hist(as.numeric(unlist(df[explanatory[i]])),
       main=paste("Plot ", explanatory[i]))
  box(lty = "solid")
}

#  duration_ms - too right skewed.
#  speechiness - almost all tracks are music and non-speech-like
#  acousticness, instrumentalness, liveness - highly right skewed (range 0 ~ 1)
#  danceability, valence, tempo - bell shaped, normal distributed

#  rescale on duration_ms to minute
df$duration_m <- df$duration_ms / 60000

par(mfrow=c(1,2))
par(bg="white")
par(mar=c(2.2,2.2,2.2,2.2))

hist(as.numeric(unlist(df['duration_ms'])),
     main="Plot duration_ms", xlim = c(0,2e+6))
box(lty = "solid")

hist(as.numeric(unlist(df['duration_m'])),
     main=paste("Plot duration_m"), xlim = c(0,30))
box(lty = "solid")

# ------------------------------------------------------------------------------
# Improve model fitness
# ------------------------------------------------------------------------------
#  70/30 train-test split
set.seed(my_cid)

train_idx <- sample(n, size = 0.7*n)
df_train <- df[train_idx, ]
df_test <- df[-train_idx, ]

explanatory <- c('duration_m', 'danceability', 'energy', 'loudness',
                 'speechiness', 'acousticness', 'instrumentalness',
                 'liveness', 'valence')

#  fit model with transformed features
attach(df_train)
model_2.lm <- lm(popularity~duration_m+danceability+energy+key+loudness
                 +mode+speechiness+acousticness+instrumentalness
                 +liveness+valence+tempo+time_signature)
summary(model_2.lm) # Multi R2 - 0.06506

model_3.lm <- lm(popularity~duration_m+danceability+energy+loudness
                 +speechiness+acousticness+instrumentalness+liveness+valence)
summary(model_3.lm) # Multi R2 - 0.06445

# ------------------------------------------------------------------------------
# Evaluate model
# ------------------------------------------------------------------------------

df_pred_2 <- data.frame(popularity = predict(model_3.lm, df_test[,explanatory]))

g_eval_2 <- ggplot() +
  geom_line(data = df_test,
            aes(x = seq(1, nrow(df_test)), y = popularity, color = "true"),
            alpha = .7) +
  geom_line(data = df_pred,
            aes(x = seq(1, nrow(df_test)), y = popularity, color = "pred"),
            alpha = .8) +
  labs(x = "Tracks", y = "Popularity")
g_eval_2

#  accuracy within plus/minus 1 sigma interval
ggplot(df_test, aes(x = seq(1, nrow(df_test)), y = popularity,
                    color = (df_pred_2$popularity<popularity+sd(popularity)) &
                      (df_pred_2$popularity>popularity-sd(popularity)))) +
  geom_point() +
  labs(x = "Tracks", y = "Popularity")

detach(df_train)

# ------------------------------------------------------------------------------
# Sub-sampling method
# ------------------------------------------------------------------------------

library(dplyr)

#  subsampling size
N <- 2000

#  hyperparameter k's
ks <- c(60, 65, 70, 75, 80)

#  subsamples and models
dfs_pop <- list()
dfs_unpop <- list()
models <- list()
dfs_pred <- list()
gs <- list()
ggs <- list()

for (i in 1:length(ks)) {

  dfs_pop[[i]] <- subset(df, popularity >= ks[i])
  dfs_unpop[[i]] <- subset(df, popularity < ks[i])

  idx_pop <- sample(nrow(dfs_pop[[i]]), size = N/2)
  idx_unpop <- sample(nrow(dfs_unpop[[i]]), size = N/2)

  dfs_pop[[i]] <- dfs_pop[[i]][idx_pop, ]
  dfs_unpop[[i]] <- dfs_unpop[[i]][idx_unpop, ]

  df_subsampling <- bind_rows(dfs_pop[[i]], dfs_unpop[[i]])
  df_subsampling <- df_subsampling[sample(1:nrow(df_subsampling)), ] # shuffle

  train_idx <- sample(N, size = 0.7*N)
  df_train <- df_subsampling[train_idx, ]
  df_test <- df_subsampling[-train_idx, ]

  attach(df_train)
  models[[i]] <- lm(popularity~duration_m+danceability+energy+loudness
                  +speechiness+acousticness+instrumentalness+liveness+valence)
  dfs_pred[[i]] <- data.frame(popularity = predict(models[[i]], df_test[,explanatory]))
  detach(df_train)

  gs[[i]] <- ggplot() +
    geom_line(data = df_test,
              aes(x = seq(1, nrow(df_test)), y = popularity, color = "true"),
              alpha = .7) +
    geom_line(data = dfs_pred[[i]],
              aes(x = seq(1, nrow(df_test)), y = popularity, color = "pred"),
              alpha = .8) +
    labs(x = "Tracks", y = "Popularity")

  #  accuracy within plus/minus 1 sigma interval
  ggs[[i]] <-ggplot(df_test, aes(x = seq(1, nrow(df_test)), y = popularity,
                      color = (dfs_pred[[i]]$popularity<popularity+sd(popularity)) &
                        (dfs_pred[[i]]$popularity>popularity-sd(popularity)))) +
    geom_point() +
    labs(x = "Tracks", y = "Popularity")
}

#  plot performance
gs[[1]]
gs[[2]]
gs[[3]]
gs[[4]]
gs[[5]]

ggs[[1]]
ggs[[2]]
ggs[[3]]
ggs[[4]]
ggs[[5]]

#  plot r-square and adj r-square
df_r <- data.frame(
  k = ks,
  R_square = c(summary(models[[1]])$r.squared,
               summary(models[[2]])$r.squared,
               summary(models[[3]])$r.squared,
               summary(models[[4]])$r.squared,
               summary(models[[5]])$r.squared),
  Adj_R_square = c(summary(models[[1]])$adj.r.squared,
                   summary(models[[2]])$adj.r.squared,
                   summary(models[[3]])$adj.r.squared,
                   summary(models[[4]])$adj.r.squared,
                   summary(models[[5]])$adj.r.squared))
ggplot() +
  geom_line(data = df_r,
            aes(x = k, y = R_square, color = "R-square")) +
  geom_line(data = df_r,
            aes(x = k, y = Adj_R_square, color = "Adjusted R-square")) +
  labs(x = "Popularity benchmark") +
  theme(axis.title.y=element_blank())

#  plot effects of features
library(tidyverse)
library(broom)
theme_set(theme_light())

df_coe <- models[[5]] %>%
  tidy(conf.int = TRUE)

df_coe %>%
  filter(term != "(Intercept)") %>%
  # reorder the coefficients so that the largest is at the top of the plot
  mutate(term = fct_reorder(term, estimate)) %>%
  ggplot(aes(estimate, term, colour = term)) +
  geom_point() +
  geom_errorbarh(aes(xmin = conf.low, xmax = conf.high)) +
  # add in a dotted line at zero
  geom_vline(xintercept = 0, lty = 2) +
  # remove the legend as the facet show that information
  theme(legend.position = "none") +
  labs(
    x = "Estimate of effect of variable (in %)",
    y = NULL,
    title = "Coefficient plot with error bars",
    subtitle = "By variable type"
  )
