module.exports =
  navigation:
    home: 'Home'
    classify: 'Investigate'
    about: 'About'
    profile: 'Profile'
    talk: 'Discuss'
    blog: 'Blog'

  home:
    intro: '''
      Help scientists analyze over 30 years of tropical cyclone satellite imagery.
    '''

    explanation: '''
      The climatology of tropical cyclones is limited by uncertainties in the historical record. Patterns in storms imagery are best recognized by the human eye, so we need your help analyzing these storms.
    '''

    campaignTitle: '2005 Campaign'
    campaignDescription: 'Help us complete all tropical cyclones imagery from 2005.'

    latestBlogPost: "Latest Blog Post"

    theStorms: '''
      Here are the storms we're currently most interested in analyzing.
    '''

    analyze: 'Analyze this storm'
    or: 'or'
    classifyRandom: 'Analyze a random storm'

    stormChangeContact: 'Check this box to be notified when these storms change!'

  about:
    header: 'About'
    subHeader: 'Learn a little more about what the heck Cyclone Center is.'
    overview:
      header: 'Lorem Ipsum Header'
      navigation: 'About Cyclone Center'
      content: '''
        <p>CycloneCenter.org is a web-based interface that enables the public to help analyze the intensities of past tropical cyclones around the globe.  The global intensity record contains uncertainties caused by differences in analysis procedures around the world and through time. Patterns in storm imagery are best recognized by the human eye, so scientists are enlisting the public. Interested volunteers will be shown one of nearly 300,000 satellite images. They will answer questions about that image as part of a simplified technique for estimating the maximum surface wind speed of tropical cyclones. The end product will be a new global tropical cyclone dataset that provides 3-hourly tropical cyclone intensity estimates, confidence intervals, and a wealth of other metadata that could not be realistically obtained in any other fashion.</p>
      '''

    introduction:
      header: 'Lorem Ipsum Header'
      navigation: 'The Images'
      content:'''
        <p>The images you see on Cyclone Center were observed by infrared sensors on weather satellites. These sensors provide an estimate of the temperature at the tops of clouds. Cloud top temperatures are very important because they give us an idea of how tall the clouds are. Temperature decreases with height in the lower atmosphere (up to 10 miles), so cold clouds are taller than warm clouds. Taller clouds are responsible for the heavy rain and thunderstorms that drive tropical cyclones.</p>
        <p>In the Cyclone Center images, the cloud top temperatures are represented by a range of colors. The scale on the image below shows the temperatures in degrees Celsius that correspond with each color.</p>
        <p>Black and gray are the warmest, indicating temperatures from 9°C (48°F) to 30°C (86°F). Often these will be the temperatures we experience at the land or ocean surface, but they can also be associated with very shallow clouds. Shades of pink go down to -30°C (-22°F). In our images, these are almost always associated with shallow clouds. Red, orange, and yellow come next, and they indicate medium-level clouds.</p>
        <p>In most images, the coldest clouds you see will be shades of blue. Sometimes you’ll even see a cloud that’s so cold it shows up as white. These clouds are colder than -85°C (-121°F). Coastlines and political borders are also drawn in white, so make sure the white clouds are surrounded by dark blue. Otherwise, you might just be looking at a small island.</p>
        <p>Sometimes there is a problem with parts of the satellite data. These missing data will show up as black lines in the images. Just ignore them and carry on with the analysis when you see them.</p>

        <div id="image-diagram">
          <img src="images/about/diagram.jpg" />
        </div>

        <h2>The <span data-popup="#mr-dvorak bottom cameo">Dvorak</span> Technique</h2>

        <p>Prior to the 1960s, tropical cyclones were rarely observed unless they moved close to populated areas, happened to move near an unfortunate ship or occurred in the North Atlantic or Western Pacific (where routine aircraft flights monitored tropical weather systems). Fortunately, geostationary satellites were developed and launched during the 1960s. These satellites orbit the earth at very high altitudes (~22,300 miles or 35,900 km), allowing them to orbit at the same speed as the earth rotates. This allows for the satellite to always “see” the same large area and thus continuously monitor the oceans for tropical cyclone activity.</p>
        <p>Despite this important advance, scientists and forecasters still had little hope of determining how strong the winds were (“intensity”) in a tropical cyclone from just looking at a picture of it. Only a very small fraction of tropical cyclones were measured directly by specially designed aircraft. However, it soon became apparent to a gentleman named Vernon Dvorak that the intensity of a tropical cyclone could be skillfully approximated by simply analyzing the cloud patterns and temperatures from a single satellite image. Dvorak developed and improved his method (now called the “Dvorak Technique”) in the 1970s and early 1980s.</p>
        <p>The technique consists of a set of 10 steps, which can be simplified to produce the answers to four important questions:</p>
        <ol>
          <li>Where is the center of the system?</li>
          <li>What type of cloud pattern best describes the system?</li>
          <li>How organized or intense is the cloud pattern?</li>
          <li>Does the system look stronger or weaker than 24 hours ago?</li>
        </ol>
        <p>Sometimes the answers to these questions are not clear, making the application of the Dvorak technique subjective. Tropical cyclone analysts and forecasters must be trained to successfully apply the many rules and constraints that the technique makes. Even then, experts frequently disagree, which has led to numerous inconsistencies in the tropical cyclone record.</p>
        <p>The Dvorak technique was adopted by many of the world’s tropical cyclone forecast centers and remains today as one of the most important tools for estimating tropical cyclone intensity. In this project, you are using a version of the Dvorak technique for classifying tropical cyclones that have formed since the late 1970s. We hope that the application of thousands of classifiers will help resolve the differences in the global tropical cyclone record and improve our understanding of how the nature of these storms may have changed through time.</p>
      '''

    organizations:
      header: 'Lorem Ipsum Header'
      navigation: 'Organizations'
      content:'''
        <div class="team-member">
          <img src="images/about/organizations/cisc.png" />
          <h4>Cooperative Institute for Climate and Satellites</h4>
          <p>The Cooperative Institute for Climate and Satellites (CICS), established under a cooperative agreement with the National Oceanic and Atmospheric Administration (NOAA) in 2009, is a consortium of research institutions that focuses on enhancing the collective interdisciplinary understanding of the state and evolution of the full Earth System. The CICS consortium is led by the University of Maryland, College Park and North Carolina State University on behalf of the University of North Carolina (UNC) System. CICS-NC is hosted by NC State University.</p>
        </div>
        <div class="team-member">
          <img src="images/about/organizations/noaa.png" />
          <h4>NOAA'S National Climatic Data Center (NCDC)</h4>
          <p>NCDC maintains the world's largest climate data archive and provides climatological services and data to every sector of the United States economy and to users worldwide. The archive contains paleoclimatic data to centuries-old journals to data less than an hour old. The Center's mission is to preserve these data and make them available to the general public, business, industry, government and researchers.</p>
        </div>
        <div class="team-member">
          <img src="images/about/organizations/asheville.png" />
          <h4>University of North Carolina at Asheville</h4>
          <p>UNC Asheville, the only designated public liberal arts university in North Carolina, offers more than 30 majors ranging from chemistry, atmospheric sciences and environmental studies to art, new media and international studies. The university is known for its award-winning undergraduate research and humanities programs.</p>
        </div>
        <div class="team-member">
          <img src="images/about/organizations/zooniverse.png" />
          <h4>The Zooniverse</h4>
          <p>The Zooniverse and the suite of projects it contains is produced, maintained and developed by the Citizen Science Alliance. The member institutions of the CSA work with many academic and other partners around the world to produce projects that use the efforts and ability of volunteers to help scientists and researchers deal with the flood of data that confronts them.</p>
        </div>
      '''

    team:
      header: 'Lorem Ipsum Header'
      navigation: 'Team'
      content:'''
        <h3>Science team</h3>

        <div class="team-member">
          <img src="images/about/science-team/chris.jpg" />
          <h4>Chris Hennon</h4>
          <p>Chris Hennon is an associate professor of atmospheric sciences at the University of North Carolina at Asheville.  Specializing in tropical cyclone formation, Chris came to Asheville after spending two years as a visiting scientist at the U.S. National Hurricane Center in Miami, Florida.  Chris enjoys golf, racquetball, and chess in his free time.</p>
        </div>
        <div class="team-member">
          <img src="images/about/science-team/ken.jpg" />
          <h4>Ken Knapp</h4>
          <p>Ken Knapp is a meteorologist at NOAA’s National Climatic Data Center in Asheville, NC. His research interests include using satellite data to observe hurricanes, clouds, and other climate variables. His career took a tropical turn in 2005 when an NCDC customer requested satellite imagery of all tropical cyclones, rejuvenating an interest in hurricanes that began with his 7th grade science fair project.</p>
        </div>
        <div class="team-member">
          <img src="images/about/science-team/carl.jpg" />
          <h4>Carl Schreck</h4>
          <p>Carl Schreck is a research meteorologist at the Cooperative Institute for Climate and Satellites (CICS-NC). He is exploring tropical weather patterns to better understand and predict how hurricanes and other tropical cyclones form. Carl’s fascination with hurricanes began when Hurricane Fran struck his hometown of Raleigh, NC in 1996.</p>
        </div>
        <div class="team-member">
          <img src="images/about/science-team/scott.jpg" />
          <h4>Scott Stevens</h4>
          <p>Scott Stevens is a research associate at the Cooperative Institute for Climate and Satellites (CICS-NC). He is working on the development of a new rainfall dataset using NOAA’s network of NEXRAD radars, specializing in data analysis and organization.  He is a private pilot and enjoys baseball and traveling in his spare time.</p>
        </div>

        <hr />

        <h3>Development team</h3>

        <div class="team-member">
          <img src="images/about/dev-team/kelly.jpg" />
          <h4>Kelly Borden</h4>
          <p>Kelly is an archaeologist by training but an educator by passion. While working at the Museum of Science and Industry and the Adler Planetarium she became an enthusiastic science educator eager to bring science to the masses. When not pondering the wonders of science, Kelly can often be found baking or spending time with her herd of cats – Murray, Ada, & Kepler.</p>
        </div>
        <div class="team-member">
          <img src="images/about/dev-team/brian.jpg" />
          <h4>Brian Carstensen</h4>
          <p>Brian is a web developer working on the Zooniverse family of projects at the Adler Planearium. Brian has a degree in graphic design from Columbia College in Chicago, and worked in that field for a number of years before finding a niche in web development.</p>
        </div>
        <div class="team-member">
          <img src="images/about/dev-team/chris.jpg" />
          <h4>Chris Lintott</h4>
          <p>Chris Lintott leads the Zooniverse team, and in his copious spare time is a researcher at the University of Oxford specialising in galaxy formation and evolution. A keen popularizer of science, he is best known as co-presenter of the BBC's long running Sky at Night program. He's currently drinking a lot of sherry.</p>
        </div>
        <div class="team-member">
          <img src="images/about/dev-team/david.jpg" />
          <h4>David Miller</h4>
          <p>As a visual communicator, David is passionate about tellings stories through clear, clean, and effective design. Before joining the Zooniverse team as Visual Designer, David worked for The Raindance Film Festival, the News 21 Initiative's Apart From War, Syracuse Magazine, and as a freelance designer for his small business, Miller Visual. David is a graduate of the S.I. Newhouse School of Public Communications at Syracuse University, where he studied Visual & Interactive Communications.</p>
        </div>
        <div class="team-member">
          <img src="images/about/dev-team/michael.jpg" />
          <h4>Michael Parrish</h4>
          <p>Michael has a degree in Computer Science and has been working with The Zooniverse for the past three years as a Software Developer. Aside from web development; new technologies, science, AI, reptiles, and coffee tend to occupy his attention.</p>
        </div>
        <div class="team-member">
          <img src="images/about/dev-team/arfon.jpg" />
          <h4>Arfon Smith</h4>
          <p>As an undergraduate, Arfon studied Chemistry at the University of Sheffield before completing his Ph.D. in Astrochemistry at The University of Nottingham in 2006. He worked as a senior developer at the Wellcome Trust Sanger Institute (Human Genome Project) in Cambridge before joining the Galaxy Zoo team in Oxford. Over the past 3 years he has been responsible for leading the development of a platform for citizen science called Zooniverse. In August of 2011 he took up the position of Director of Citizen Science at the Adler Planetarium where he continues to lead the software and infrastructure development for the Zooniverse.</p>
        </div>
      '''

  profile:
    hello: 'Hello'
    imageCount: 'Images Marked'
    favoriteCount: 'Favorite Count'
    recents: 'Recents'
    favorites: 'Favorites'

  classify:
    header: 'This is your task! Analyze each storm, then do something else.'
    favorite: 'Favorite'
    continue: 'Continue'
    finish: 'Finish'
    restart: 'Restart'
    guide: 'Guide'
    favorite: 'Favorite'
    favorited: 'Favorited'
    talkSubject: 'Discuss the image'
    talkGroup: 'Discuss the storm'
    share: 'Share on Facebook'
    tweet: 'Tweet this'
    next: 'Next'

    restartTutorial: 'Tutorial'
    slideTutorial: 'Site Intro'

    notSignedIn: '''
      You're not logged in! Logged in volunteers can keep track of what they've worked on, and receive credit for their work in publications. It also helps us combine everyone's classifications more efficiently.
    '''

    pleaseSignIn: '''
      Please log in now
    '''

    or: 'or'

    signUp: '''
      sign up for a new account.
    '''

    matches:
      postTropical: 'Post-Tropical'
      edge: 'Edge'
      noStorm: 'No Storm'

    categories:
      eye: 'Eye'
      embedded: 'Embedded'
      curved: 'Curved'
      shear: 'Shear'
      other: 'Other'

    strengths:
      older: 'Left'
      olderTop: 'Top'
      same: "They're about the same"
      current: 'Right'
      currentBottom: 'Bottom'

    steps:
      stronger:
        instruction: 'Choose the storm image that appears <strong>stronger</strong>.'
        explanation: '''
          <h2>Choose the storm image that appears stronger</h2>
          <p>To determine which storm is stronger, consider two questions:</p>

          <h2>Which storm has colder clouds?</h2>
          <p>Colder colors in infrared satellite imagery indicate taller clouds that release more energy into a storm. Stronger storms have more of these cold clouds near their centers.</p>

          <h2>How organized are the clouds?</h2>
          <p>Stronger storms have tighter spirals, especially near the center where the cold clouds become more circular. For example, storms with an eye are almost always stronger than storms without one. The strongest cyclones have eyes that are more circular, smaller and/or warmer in the middle.</p>

          <h2>Use the images below as a guide:</h2>
          <img src="images/field-guide/strength-chart.jpg" />
        '''

      catAndMatch:
        instruction: 'Pick the cyclone type, then choose the closest match.'
        explanation: '''
          <table>
            <tbody>
              <tr>
                <td>
                  <img src="./images/matches/eye-6.0.thumb.png" width="175" height="175" />
                </td>
                <td>
                  <h3>Eye Storms</h3>
                  <p>These are the easiest storms to spot and the most powerful of tropical cyclones. They have a characteristic ‘eye’ in the center which is warmer than the surrounding cooler clouds called the ‘eyewall’. Sometimes the eye will be pink or gray but it can also just be a circular area of clouds warmer than those surrounding it.</p>
                </td>
              </tr>

              <tr>
                <td>
                  <img src="./images/matches/embed-4.5.thumb.png" width="175" height="175" />
                </td>
                <td>
                  <h3>Embedded Center Storms</h3>
                  <p>These storms have a roundish area of colder clouds near the center. They are weaker than eye and stronger than curved-band storms. Weak embedded center storms can look like curved bands, strong embedded center storms may be starting to form an eye.</p>
                </td>
              </tr>

              <tr>
                <td>
                  <img src="./images/matches/band-2.5.thumb.png" width="175" height="175" />
                </td>
                <td>
                  <h3>Curved Band Storms</h3>
                  <p>These can be hard to identify - they’re more disorganized than eyes or embedded centers. Look for a comma shape storm without a round area of cold clouds at the center.</p>
                </td>
              </tr>

              <tr>
                <td>
                  <img src="./images/matches/shear-2.5.thumb.png" width="175" height="175" />
                </td>
                <td>
                  <h3>Shear Storms</h3>
                  <p>Most easily recognised by a flattened side with all the colors squeezed very close together. A vertical shear causes the tallest clouds to be displaced to one side of the storm.</p>
                </td>
              </tr>

              <tr>
                <td>
                </td>
                <td>
                  <h3>Other Categories</h3>
                </td>
              </tr>

              <tr>
                <td>
                  <img src="./images/matches/other-post-tropical.png" width="175" height="175" />
                </td>
                <td>
                  <p><strong>Post tropical:</strong> If the storm doesn’t fit any of the other categories then it might be a post-tropical storm. These are identified by large amounts of warm clouds (gray and pink) and often have a long tail extending from the center.</p>
                </td>
              </tr>
              <tr>
                <td>
                  <img src="./images/matches/other-limb.png" width="175" height="175" /><br />
                </td>
                <td>
                  <p><strong>Edge:</strong> Sometimes the images will be skewed because of the limited view of the satellite. In this case try and classify the storm as normal - if that’s not possible then mark it as ‘edge’.</p>
                </td>
              </tr>
              <tr>
                <td>
                  <img src="./images/matches/other-no-storm.png" width="175" height="175" />
                <td>
                  <p><strong>No storm:</strong> Early in a storm’s lifetime it might not be possible to say anything about its shape. If there is no evidence of an organised spiral structure then mark ‘no storm’.</p>
                </td>
              </tr>
            </tbody>
          </table>
        '''

      center:
        heading: 'Click the <strong>center</strong> of the storm.'
        explanation: '''
          <section class="for-embedded center-embedded-center">
            <h2>Finding the Center (Embedded Center)</h2>
            <img src="images/field-guide/center-embedded-center.jpg" class="example"/>
            <p>In an Embedded Center storm the center is embedded within the coldest clouds; no eye is present.</p>
            <h3>What to look for:</h3>
            <p>Follow the swirl of clouds inward to a single point, traveling along a spiral. The center isn’t necessarily under the coldest clouds, so be careful not to get distracted by a spot of colder colors.</p>
            <p>Here the clouds are spiraling inward along the black arrows. It may be tempting to click the area of dark blue clouds, but if you follow the arrows all the way in, you’ll see that the focus of circulation is actually slightly to the southeast, shown by the white crosshairs.</p>
          </section>

          <section class="for-curved center-curved-band">
            <h2>Click the center of the storm (Curved Band)</h2>
            <img src="images/field-guide/center-curved-band.jpg" class="example" />
            <p>The center of circulation in a Curved Band storm can be found by following the spirals inward to a single point.</p>
            <h3>What to look for:</h3>
            <p>Curved Band storms sometimes spiral around a wedge of warmer clouds. The center of the storm is often near where the cold spiral meets this warm wedge.</p>
          </section>

          <section class="for-shear center-shear">
            <h2>Click on the Storm Center (Shear)</h2>
            <img src="images/field-guide/center-shear.jpg" class="example" />
            <p>These are called Shear storms because they are encountering a cold front, or other large weather system, whose winds vary, or shear, with height. This shear tilts the storm over to one side.</p>
            <h3>What to look for:</h3>
            <p>The asymmetry of a Shear storm makes it tricky to find it’s center because tall clouds are prevented from developing on one side of the cyclone. Sometimes, like in this example, you can still see a small swirl in the gray and pink (warmer) clouds. If you see one of these, follow the swirl as it spirals into the center.</p>
            <p>Shallow clouds may be difficult to find on infrared images. If you have trouble with the swirl method, look at the shield of cold clouds. In Shear storms, the colors will be very close together on one side of the storm, sometimes aligned in a straight line. That’s where the cold clouds are developing, before being blown away by the shear. The center of the storm will usually be nearby.</p>
          </section>
        '''

      centerEyeSize:
        heading: 'Click the <strong>center</strong> of the storm, then pick the size closest to the eye edge.'
        explanation: '''
          <h2>Click the center of the storm, then choose the size of the eye.</h2>
          <img src="./images/field-guide/center-eye.jpg" class="example" />
          <p>A cyclone’s eye, a mostly cloudless and rain free area, forms at its center of circulation.</p>
          <h3>What to look for:</h3>
          <p>Identify the eye and center of the storm:</p>
          <p>Look for a very warm area near the center of the storm surrounded by a ring of very cold clouds. Finding the center of the storm is easy, it’s the center of the eye.</p>
          <h3>Eye size:</h3>
          <p>Select the circle that best matches the size of the eye and drag it with your mouse so that it traces the eye. Think of the edge of the eye as the point where the colors are closest together. If you need to change the size, click on a different-sized circle.</p>
          <p><strong>Why it’s important:</strong> Storms with smaller eyes typically have tighter and stronger circulation, and are therefore a stronger storm.</p>
        '''

      surrounding:
        heading: 'Which colors completely surround the eye?'
        explanation: '''
          <h2>Which colors completely surround the eye?</h2>
          <img src="./images/field-guide/surrounding.jpg" class="example" />
          <p>A tropical cyclone’s eye is surrounded by a ring of tall clouds called the eyewall.</p>
          <h3>What to look for:</h3>
          <p>Look for the coldest color completely surrounding the eye of the cyclone in an unbroken ring. It doesn’t matter how thick or thin the ring is, or even if it’s not circular, only that it is continuous all the way around.</p>
          <p>Think of these storms as a layer cake, with warmer cloud layers underneath colder ones.  If you removed all of the light blue colors, you would see yellow beneath them, and orange beneath those. In the example below, the cyan ring doesn’t quite connect all the way around, but the light blue beneath it does. Since the light blue completes a ring, that means that yellow, orange, and all the layers of the cake beneath it also wrap all the way around. You only need to select light blue.</p>
          <p><strong>Why it’s important:</strong> Cloud temperatures decrease with height, so stronger storms can be identified by finding the coldest cloud tops. By identifying which colors surround the eye of the storm in the eyewall, you’ll determine how tall these clouds are, helping to estimate the strength of the cyclone.</p>
        '''

      exceeding:
        heading: 'Choose the colors completely surrounding the eye at least 0.5° thick.'
        instruction: 'Drag your mouse over the image to reveal a measuring tool.'
        explanation: '''
          <h2>Choose the colors completely surrounding the eye that is at least 0.5° thick</h2>
          <img src="./images/field-guide/exceeding.jpg" class="example" />
          <h3>What to look for:</h3>
          <p>Hover over the image to make a small measuring tool appear. Find the coldest color completely surrounding the eye that also completely fills the circle at all points around the ring. The light blue wrapped all the way around the storm is thick enough in most places, but not southwest of the eye. In that region there is some yellow peaking through the measuring tool. That small bit of yellow is enough to eliminate the light blue for this step.</p>
          <p>The yellow might not seem thick enough either. However, remember how a storm is like a layer cake. If one ring isn’t quite thick enough, imagine removing it and exposing the next warmer color below, and so forth until you find one thick enough. There is a yellow layer underneath the blue one, so we can consider these blues as part of the yellow. In that case, the yellow is more than thick enough.</p>
          <p><strong>Why it’s important:</strong> This tells us not only how tall the clouds are, but how widespread as well. Storms with a larger area of cold clouds are typically more intense.</p>
        '''

      feature:
        heading: 'Choose the image that matches the banding feature. <span class="thickness"></span>'
        explanation: '''
          <h2>Does the band wrap less than a quarter, about a quarter, half or more?</h2>
          <img src="./images/field-guide/feature-embedded-center.jpg" class="example" />
          <p>Strong tropical cyclones often have long spiral bands. A band is defined as a spiral arm that is orange or colder, separated from the main storm by a wedge of red or warmer clouds.</p>
          <h3>What to look for:</h3>
          <p>You’ll determine how far the band wraps around the storm. Choose an icon from the three below the image to indicate whether the band wraps less than a quarter way around the storm, a quarter-way around the storm, or halfway or more around the storm. If a storm doesn’t have spiral bands select the first icon.</p>
          <p>The example here has a wide band along the north side of the storm. This band is relatively short and it doesn’t wrap very far around the storm’s center. In this case, choose the first icon.</p>
        '''

      blue:
        heading: 'Which colors wrap most of the way around the band?'
        explanation: '''
          <h2>Which colors wrap most of the way around the band?</h2>
          <img src="./images/field-guide/color.jpg" class="example" />
          <h3>What to look for:</h3>
          <p>You’ll identify the primary color of the Curved Band itself. Simply look at the band and choose the coldest color that extends along most of the band. In this example there are some patches of light blue, and even cyan, but they are too sparse to be considered widespread, so you would choose yellow.</p>
          <p><strong>Why is this important:</strong> This provides information on the cyclone’s strength. Colder, taller clouds release more energy into a tropical cyclone. We identify these taller storms in infrared satellite images by looking for colder cloud tops. Remember white and blue represent the coldest clouds and pink and grey represent the warmest clouds. Stronger tropical cyclones will have more of these tall, cold clouds.</p>
        '''

      curve:
        heading: 'How far does the main band wrap?'
        explanation: '''
          <h2>How far does the main band wrap?</h2>
          <img src="./images/field-guide/wrap.jpg" class="example" />
          <p>A Curved Band storm’s strength is measured by the length of the band. The longer the band, the stronger the storm.</p>
          <h3>What to look for:</h3>
          <p>Focus on how far around the band wraps, and click on the picture that best matches it. In this example, the band wraps around about one-half of a full circle, so we’d choose the second picture.</p>
        '''

      red:
        heading: 'Click the nearest red point to the storm center.'
        explanation: '''
          <h2>Click the red point nearest to the storm center that is associated with the main cloud feature</h2>
          <img src="./images/field-guide/red.jpg" class="example" />
          <h3>What to look for:</h3>
          <p>You’re marking the distance from the center that you marked in the last step to the storm’s main thunderstorms.  Click the red point closest to the center that you previously marked.</p>
          <p>Here, the center (marked with a white crosshair) is just outside the main thunderstorms. Sometimes the center will be within the cold colors, but we’ll still need to know how far the center is from the edge of the coldest clouds. Click the edge of the main storm (the nearest red point), and a second crosshair will appear. The distance between these clicks will tell us the storm’s strength.</p>
          <p><strong>Why is this important:</strong> This tells us how tilted or straight the storm is, and therefore, how strong it is.</p>
        '''

      reveal:
        tutorialSubject: '(Tutorial image)'
        estimated: 'Possible wind speed, based on your classification:'
        windAndPressure: 'Wind speed and pressure'

  tutorial:
    welcome:
      header: '''Welcome to Cyclone Center!'''
      details: '''
        By comparing satellite images to assess storm type and strength, you’re helping meteorologists understand the history of tropical cyclone weather patterns.
        This tutorial will show you how to identify tropical cyclone type and strength. Let’s go!
      '''

    temperature:
      header: '''Cloud Color & Temperature'''
      details: '''
        White and blue clouds are the coldest and pink and grey clouds are the warmest.
        This is important to keep in mind as you are categorize storm type and strength.
      '''

    chooseStronger:
      header: '''Storm Strength'''
      details: '''
        To determine which is stronger look for the presence of colder clouds and a more organized system.
        The image on the right has more cold clouds and is more organized, so let’s select it as the stronger storm.
      '''
      instruction: '''Click the storm image on the right.'''

    postStronger:
      header: '''Storm Strength'''
      details: '''
        And click continue to move to the next step...
      '''
      instruction: '''Click "Continue".'''

    chooseEmbeddedType:
      header: '''Cyclone Type'''
      details: '''
        Now let’s figure out what type of storm we’re looking at.
        There are four main types of tropical cyclones – Eye, Embedded Center, Curved Band, and Shear.
        Let’s checkout embedded centers first. We can choose a different type if we find this one doesn't match.
      '''
      instruction: '''Choose "Embedded Center".'''

    chooseEyeType:
      header: '''Cyclone Type'''
      details: '''
        These images look similar, but not quite right. Let’s try a different storm type. Select Eye.
      '''
      instruction: '''Choose "Eye" instead.'''

    chooseMatch:
      header: '''Cyclone Type'''
      details: '''
        From left to right the storm images get stronger.
        The clouds in this storm seem very cold and organized, similar to those in the fourth image.
        Let's choose it as our closest match.
      '''
      instruction: '''Click the fourth eye image.'''

    postMatch:
      header: '''Cyclone Type'''
      details: '''
        This looks like a close match, and even if it's off by a bit, our classifications will be compared against other volunteers' classifications of the same image. Let's move on.
      '''
      instruction: '''Click "Continue".'''

    chooseCenter:
      header: '''Center and Eye Size'''
      details: '''
        Now let's click the center of the storm. For an eye storm, it's simply the center of the eye.
      '''
      instruction: '''Click the center of the storm.'''

    chooseSize:
      header: '''Center and Eye Size'''
      details: '''
        Choose the size that most closely matches the eyewall. For more help, always remember to read the details on the right.
      '''
      instruction: '''Choose the second circle.'''

    postChooseSize:
      header: '''Center and Eye Size'''
      details: '''
        That looks like a great fit. If you're unsure, remember that your classification is one of many, so just do your best!
      '''
      instruction: '''Click "Continue".'''

    chooseSurrounding:
      header: '''Coldest Surrounding Clouds'''
      details: '''
        Now we need to determine the coldest unbroken ring around the eye.
        Moving from the eye out, we can see that the beige, orange, red, yellow, and light blue bands are all continuous.
        The cyan band is broken, so let's choose the light blue as the coldest continuous band.
      '''
      instruction: '''Choose the teal/blue swatch, 6th from the left.'''

    postSurrounding:
      header: '''Coldest Surrounding Clouds'''
      details: '''Great!'''
      instruction: '''Click "Continue".'''

    chooseColdestThick:
      header: '''Coldest Surrounding Thick Band of Clouds'''
      details: '''
        Now we want to do the same thing, but only for band 0.5° thick.
        Hovering over the image will show you a box you can use to measure that thickness.
        Choose the color that fills that box all the way around.
        Remember: Colder color include warmer colors.
        Here, it appears the teal/blue band is thick enough all the way around the eye.
      '''
      instruction: '''Choose the teal/blue swatch again.'''

    postColdestThick:
      header: '''Coldest Surrounding Thick Band of Clouds'''
      details: '''
        Excellent.
      '''
      instruction: '''Click "Continue".'''

    chooseBandingFeature:
      header: '''Banding Feature'''
      details: '''
        Now let's identify the length of the storm's spiral bands.
        This storm doesn't have very strong banding, so let's choose the first option.
      '''
      instruction: '''Choose the first option.'''

    postBandingFeature:
      header: '''Banding Feature'''
      details: '''
        We're almost finished!
      '''
      instruction: '''Click "Continue" one more time.'''

    goodLuck:
      header: '''Good Luck!'''
      details: '''
        Now you’re ready to classify tropical cyclones! Remember to check-out the ? Buttons for more information if you have questions.
        Classifying storms is tricky, but we know that our volunteers do a great job. Just do your best, your opinion is important.
        Click Next storm to move to your next storm.
      '''
      instruction: '''Click "Next" to get started on your own!'''

  progress:
    25: "Congratulations! You’ve just identified your first storm. Could you do at least 3 more?"
    50: "Two storms down, two to go! You’re doing great; keep it up!"
    75: "All right! You’re almost there! Just one storm left!"
    100: "Great job, stormwatcher! You’ve observed 4 storms and already helped our project tremendously. Now that you’re a pro, why not keep going?"
