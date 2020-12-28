header <- dashboardHeader(title = "Spotify")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Overview", tabName = "overview", icon = icon("music")),
    menuItem(text = "Track Statistics", tabName = "stats", icon = icon("chart-line")),
    menuItem(text = "Dataset", tabName = "data", icon = icon("database"))
  )
)

body <- dashboardBody(
  tabItems(
    
    #===============#
    #     Tab 1     #
    #===============#
    
    tabItem(tabName = "overview", 
            
            fluidPage(
              h2(tags$b("Spotify: The Decade Decoded")),
              div(style = "text-align:justify", 
                  p("Music has always been taking a big part of our day to day lives, 
                    from having a shower, driving to work, studying, or waiting for someone.
                    Believe it or not, music is constantly reshaping (and being reshaped by) our diverse cultures.
                    Shifts in music taste can be experienced globally with the rise of digital technology in recent decades.
                    Today, Spotify alone - as the world’s most popular audio streaming subscription service - 
                    has 320 Million users, including 144 Million subscribers, across 92 markets."
                  ),
                  br()
              )
            ),
            
            fluidRow(
              valueBox("144 Million", "Subscribers", icon = icon("play-circle"), color = "blue"),
              valueBox("320 Million", "Monthly active users", icon = icon("users"), color = "green"),
              valueBox("92", "Markets", icon = icon("globe-asia"), color = "blue"),
              valueBox("60 Million+", "Tracks", icon = icon("music"), color = "green"),
              valueBox("1.9 Million+", "Podcasts", icon = icon("podcast"), color = "blue"),
              valueBox("4 Billion+", "Playlists", icon = icon("record-vinyl"), color = "green")
            ),
            
            wordcloud2Output("wordcloud2"),
            br(),
    ),
    
    #===============#
    #     Tab 2     #
    #===============#
    
    tabItem(tabName = "stats", 
            
            # upper plot
            
            fluidPage(
              h2(tags$b("Looking Back: 2010s Songs")),
              br(),
              box(width = 8,
                  solidHeader = T,
                  title = tags$b("What Songs do People Listen to?"), 
                  plotlyOutput("bar_plot")
              ),
              box(width = 4,
                  solidHeader = T,
                  height = 195,
                  background = "blue",
                  selectInput(inputId = "year1", 
                              label = "Select Year",
                              choices = unique(data_2010s$Year))
              ),
              valueBoxOutput(width = 4, "SOTY"),
              valueBoxOutput(width = 4, "Popularity"),
              br()
            ),
            
            # middle plot
            
            fluidPage(
              tabBox(width = 9,
                     title = tags$b("What Makes Songs Similar?"),
                     side = "right",
                     tabPanel(tags$b("by Mode"), 
                              plotlyOutput("plot_corr_mode", height=480)
                     ),
                     tabPanel(tags$b("by Explicitness"), 
                              plotlyOutput("plot_corr_explicit", height=480)
                     )
              ),
              box(width = 3,
                  solidHeader = T,
                  background = "blue",
                  selectInput(inputId = "year2", 
                              label = "Select Year",
                              choices = unique(data_2010s$Year))
              ),
              box(width = 3,
                  solidHeader = T,
                  background = "green",
                  selectInput(inputId = "xlabel", 
                              label = "Select X Axis",
                              choices = data_2010s %>% 
                                select('Energy', 'Valence', 'Acousticness', 'Danceability', 'Duration', 
                                       'Instrumentalness', 'Liveness', 'Loudness', 'Speechiness', 'Tempo') %>% 
                                names()),
                  selectInput(inputId = "ylabel", 
                              label = "Select Y Axis",
                              choices = data_2010s %>% 
                                select('Loudness', 'Valence', 'Acousticness', 'Danceability', 'Duration', 
                                       'Instrumentalness', 'Liveness', 'Energy', 'Speechiness', 'Tempo') %>% 
                                names())
              ),
              box(tags$b("Choose whether to display trend"),
                  width = 3,
                  solidHeader = T,
                  background = "navy",
                  checkboxInput("trend", "Display trend", FALSE)
              ),
              box(width = 3,
                  solidHeader = T,
                  background = "navy",
                  sliderInput("head", "Number of data", min = 100, max = 2100, value = 1000)
              )
            ),
            
            # lower plot
            
            fluidPage(
              box(width = 8,
                  solidHeader = T,
                  title = tags$b("Preference Shifts in Music"), 
                  plotlyOutput(outputId = "time_series")
              ),
              box(width = 4,
                  height = 460,
                  background = "navy",
                  h3("It's changing!"),
                  div(style = "text-align:justify",
                      p("Music has been less acoustic and instrumental for the last 7 decades.
                        This means that many tracks nowadays were made through electric or electronic means (less acoustic)
                        and contains more vocal content like spoken words (less instrumental). The year 2020 marks their lowest points."),
                      p("As the acousticness and instrumentalness plummeted down, the energy went up,
                        meaning that many tracks are getting more perceptual measure of intensity and activity within."),
                      p("Liveness (presence of an audience in the recording) has been relatively stable throughout the years."),
                      p(tags$b("What will the future music sound like?"))
                  )
              )
            )
    ),
    
    #===============#
    #     Tab 3     #
    #===============#
    
    tabItem(tabName = "data", 
            fluidPage(
              h2(tags$b("Understanding Data")),
              br(),
              dataTableOutput(outputId = "data"),
              br(),
              div(style = "text-align:justify", 
                  p("This dashboard uses a dataset from ", tags$a(href="https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks", "kaggle"), " which is cleaned separately, and revolves around the followings:"),
                  tags$ul(
                    tags$li("Name - The title of the track."), 
                    tags$li("Artists - The artists involved in the making of the track."), 
                    tags$li("Year - The track's year of release."), 
                    tags$li("Duration - The duration of the track."), 
                    tags$li("Key - The estimated overall key of the track. Integers map to pitches using standard Pitch Class notation (e.g. 0 = C, 1 = C♯/D♭, 2 = D, and so on). If no key was detected, the value is -1."), 
                    tags$li("Mode - Mode indicates the modality (major or minor) of a track, the type of scale from which its melodic content is derived."),
                    tags$li("Explicit - Explicit indicates whether the track contains explicit contents."),
                    tags$li("Acousticness - A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic."),
                    tags$li("Danceability - Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable."),
                    tags$li("Energy - Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy. For example, death metal has high energy, while a Bach prelude scores low on the scale. Perceptual features contributing to this attribute include dynamic range, perceived loudness, timbre, onset rate, and general entropy."),
                    tags$li("Instrumentalness - Predicts whether a track contains no vocals. “Ooh” and “aah” sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly “vocal”. The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content. Values above 0.5 are intended to represent instrumental tracks, but confidence is higher as the value approaches 1.0."),
                    tags$li("Liveness - Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live."),
                    tags$li("Loudness - The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Loudness is the quality of a sound that is the primary psychological correlate of physical strength (amplitude). Values typical range between -60 and 0 db."),
                    tags$li("Speechiness - Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech, either in sections or layered, including such cases as rap music. Values below 0.33 most likely represent music and other non-speech-like tracks."),
                    tags$li("Valence - A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry)."),
                    tags$li("Tempo - The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration."),
                    tags$li("Popularity - The popularity of the track. The value will be between 0 and 100, with 100 being the most popular. The popularity is calculated by algorithm and is based, in the most part, on the total number of plays the track has had and how recent those plays are. Generally speaking, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past. Artist and album popularity is derived mathematically from track popularity. Note that the popularity value may lag actual popularity by a few days: the value is not updated in real time.")
                  ),
                  br()
              )
            )
    )
  )
)

dashboardPage(
  header = header,
  body = body,
  sidebar = sidebar, 
  skin = "green"
)