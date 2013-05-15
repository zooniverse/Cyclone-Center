module.exports =
  navigation:
    home: 'Home'
    about: 'About'
    classify: 'Classify'
    profile: 'Profile'
    talk: 'Discuss'
    blog: 'Blog'

  home:
    intro: '''
      Climate scientists need your help analyzing more than 30 years of tropical cyclone satellite imagery.
    '''

    explanation: '''
      Differences in analysis around the world and through time have caused uncertainties in the global cyclone tensity record.
      Scientists are enlisting the public because patterns in storm imagery are best recognized by the human eye.
    '''

    analyze:'Analyze this storm'

    or: 'or'

    classifyRandom: 'Classify a random storm'

  classify:
    favorite: 'Favorite'
    continue: 'Continue'
    finish: 'Finish'
    talkSubject: 'Discuss the image'
    talkGroup: 'Discuss the storm'
    share: 'Share on Facebook'
    tweet: 'Tweet this'
    next: 'Next'

    details:
      stronger: '''
        <h3>Which storm appears stronger?</h3>
        <p>An important part of estimating the strength of a storm is knowing whether that storm is getting stronger, weaker or staying about the same. To help us with that, the first step of most classifications is to ask which of two images looks stronger. These are actually two images of the same storm taken within 24 hours.</p>
        <p>If the image you see is from the first 24 hours of the storm (or the image 24 hours prior is missing) then you’ll skip this step.</p>
        <p>A number of characteristics determine whether a storm is stronger, weaker or about the same.  There are two main measures of strength to look for:</p>
        <p><strong>1. How cold are the clouds?</strong></p>
        <p>Colder colors in infrared imagery indicate taller clouds that release more energy into a storm. Stronger tropical cyclones tend to have taller clouds and more of them. For example:</p>
        <ul>
          <li>The presence of more colder colored clouds in an embedded center suggest a stronger storm.</li>
          <li>Colder clouds surrounding an eye suggest a stronger storm.</li>
        </ul>
        <p><strong>2. How organized are the clouds?</strong></p>
        <p>This question is a bit more subjective, so just give it your best shot. Some features that might indicate which storm image is stronger:</p>
        <ul>
          <li>Stronger storms have spirals that wrap farther around the storm.</li>
          <li>The cold clouds near the center become more circular as a storm strengthens.</li>
          <li>Typically Shear and Curved Band storms are weaker than those with an Embedded Center.</li>
          <li>Storms with an eye are almost always stronger than storms without one.</li>
          <li>For storms with an eye, consider the shape, size and color of the eye. Eyes that are more circular, smaller and/or warmer tend to be associated with stronger tropical cyclones.</li>
        </ul>
        <p>In some cases, the storm on the left may appear to have some of these characteristics, while the storm on the right may appear to have others.  If this is the case, they can actually cancel out, in which case we would say that they are about the same.  For example:  If the storm on the left appears better organized and more tightly-wrapped, but the storm on the right has more cold colors, you would say that they are about the same.</p>
        <p>You can use the images below to help you gauge a storm’s relative strength.</p>
        <p><img src="images/field-guide/strength-chart.jpg" data-popup="#strength-chart right" /></p>
        <div id="strength-chart" class="popup-content"><img src="images/field-guide/strength-chart.jpg" /></div>
      '''

      catAndMatch: '''
        <section data-page="eye">
          <h3>Eye Storms</h3>
          <p>Eye storms are the most easily recognized of tropical cyclones, defined by their characteristic “eye” in the center of the storm.  The eye is a warmer area in the center of the storm, surrounded by colder clouds (the “eyewall”).  In stronger storms, the eye will appear as pink or gray, but it may simply be a circular area of clouds that are warmer clouds.   Remember white and blue are the coldest clouds while pink and  gray are the warmest clouds.</p>
          <p>Stronger eye storms typically have the following characteristics:</p>
          <ul>
            <li>More circular or warmer eye</li>
            <li>Colder clouds in the eyewall</li>
            <li>Spiral bands that wrap farther around the eyewall</li>
          </ul>
          <p><img src="images/field-guide/eye.jpg" data-popup="#eye-example right" /></p>
          <div id="eye-example" class="popup-content"><img src="images/field-guide/eye.jpg" /></div>
        </section>

        <section data-page="embedded-center">
          <h3>Embedded Center Storms</h3>
          <p>Embedded Center storms are recognized by a relatively round area of colder clouds near the center of a storm.  With regard to strength, these storms generally fall between Curved Bands and Eye Storms.  The weakest Embedded Center storms will often resemble Curved Bands, while the very strongest of Embedded Center storms may start to develop an eye.</p>
          <p>Characteristics of stronger Embedded Center storms include the following:</p>
          <ul>
            <li>Colder clouds near the center of the storm</li>
            <li>Center looks more circular than surrounding areas</li>
            <li>Pronounced spiral bands</li>
          </ul>
          <p><img src="images/field-guide/embedded-center.jpg" data-popup="#embedded-center-example right" /></p>
          <div id="embedded-center-example" class="popup-content"><img src="images/field-guide/embedded-center.jpg" /></div>
        </section>

        <section data-page="curved-band">
          <h3>Curved Band Storms</h3>
          <p>Curved Band storms are often more disorganized and more difficult to identify than Eye Storms or Embedded Centers. They are generally shaped like commas and may resemble a very weak Embedded Center. However, unlike Embedded Centers, they do not have a round area of cold cloud near their center.</p>
          <p>Storms that don’t fit any other category are often classified as Curved Bands.</p>
          <p>Stronger Curved Band storms generally display the following characteristics:</p>
          <ul>
            <li>More tightly wrapped bands</li>
            <li>Longer bands</li>
            <li>Colder clouds along the band</li>
          </ul>
          <p><img src="images/field-guide/curved-band.jpg" data-popup="#curved-band-example right" /></p>
          <div id="curved-band-example" class="popup-content"><img src="images/field-guide/curved-band.jpg" /></div>
        </section>

        <section data-page="shear">
          <h3>Shear Storms</h3>
          <p>Shear Storms are most easily recognized by a cloud pattern which appears almost flattened on one side, with the colors squeezed very close together.  They may also appear with a pronounced swirl in the gray clouds just outside the main storm.</p>
          <p>Shear storms can be difficult to identify, depending on how organized the clouds have become.  They are experiencing vertical shear, when winds at the top are different from the winds at the bottom, causing the storm to tilt to one side.   Because of this tilt, tall clouds are mostly displaced toward one side of the storm, away from the center.</p>
          <p>You can identify a stronger Shear storm with the following traits:</p>
          <ul>
            <li>Center of gray swirl is closer to (or even within) the colored clouds</li>
            <li>The cold area (colored) has a tight swirl itself and is better organized</li>
          </ul>
          <p><img src="images/field-guide/shear.jpg" data-popup="#shear-example right" /></p>
          <div id="shear-example" class="popup-content"><img src="images/field-guide/shear.jpg" /></div>
        </section>

        <section data-page="other">
          <h3>Other Storms</h3>
          <p>Sometimes you’ll encounter an image that doesn’t fit very well into any of these categories.  These are a few of the possibilities that don’t fall into these storm types.</p>
          <p><strong>Post-Tropical Storms</strong></p>
          <p>Post-tropical storms are storms that have lost their tropical nature. They become more like mid-latitude storms.  Typically they are made up of much warmer clouds (gray and pink) and have very long tails extending far from the main storm. Very often a storm becomes Post-Tropical toward the end of its life.</p>
          <p><img src="images/field-guide/post-tropical.jpg" data-popup="#post-tropical-example right" /></p>
          <div id="post-tropical-example" class="popup-content"><img src="images/field-guide/post-tropical.jpg" /></div>
          <p><strong>Edge</strong></p>
          <p>Since Earth is curved, and the satellites used to collect these images remain fixed in position above one place on the surface, a storm is usually not directly beneath a satellite.  In fact, eventually the storm may move completely out of the satellite’s field of view.  As the storm moves over the horizon, it can appear very distorted in the image, and may even be cut off by the horizon itself.</p>
          <p>You will be able to recognize these cases because the image may appear very skewed, and a portion may appear black.</p>
          <p><strong>Note: If it is possible to do a classification anyway, you should do the classification as normal.  Only choose this option if it is not possible to complete a classification.</strong></p>
          <p><img src="images/field-guide/edge.jpg" data-popup="#edge-example right" /></p>
          <div id="edge-example" class="popup-content"><img src="images/field-guide/edge.jpg" /></div>
          <p><strong>No Storm</strong></p>
          <p>Early in a storm’s lifetime it may not resemble a storm at all.  In this case, the image will appear to contain a field of disorganized clouds, with no structure that can be classified.  The image below has some tall clouds, but there’s no evidence of spiral bands that would indicate the storm is becoming more organized. In this case, select “No Storm”.</p>
          <p><img src="images/field-guide/no-storm.jpg" data-popup="#no-storm-example right" /></p>
          <div id="no-storm-example" class="popup-content"><img src="images/field-guide/no-storm.jpg" /></div>
        </section>
      '''

      center: '''
        <section data-page="center-embedded-center">
          <h3>Finding the Center</h3>
          <p>In an Embedded Center storm the center is embedded within the coldest clouds; no eye is present.  In order to find the center follow the swirl of clouds inward to a single point, traveling along a spiral. The center is not necessarily under the coldest clouds, so be careful not to get distracted by a spot of colder colors.</p>
          <p>In the example below, you can see the clouds spiralling inward along the black arrows.  It may be tempting to click the area of dark blue clouds, but if you follow the arrows all the way in, you’ll see that the focus of circulation is actually slightly to the southeast, shown here by the white crosshairs.</p>
          <p><img src="images/field-guide/center-embedded-center.jpg" data-popup="#center-embedded-center-guide right" /></p>
          <div id="center-embedded-center-guide" class="popup-content"><img src="images/field-guide/center-embedded-center.jpg" /></div>
        </section>

        <section data-page="center-curved-band">
          <h3>Click the center of the storm</h3>
          <p>As with the other storm types, the center of circulation in a Curved Band storm can be found by following the spirals inward to a single point.</p>
          <p>Curved Band storms sometimes spiral around a wedge of warmer clouds. The center of the storm is often near where the cold spiral meets this warm wedge.</p>
          <p><img src="images/field-guide/center-curved-band.jpg" data-popup="#center-curved-band-guide right" /></p>
          <div id="center-curved-band-guide" class="popup-content"><img src="images/field-guide/center-curved-band.jpg" /></div>
        </section>

        <section data-page="center-shear">
          <h3>Click on the Storm Center</h3>
          <p>Tropical cyclones are known for their strong winds. Believe it or not, these storms can actually be blown over! These tilted storms are called Shear storms because they are encountering a cold front, or other large weather system, whose winds vary, or shear, with height. This shear tilts the storm over to one side.</p>
          <p>The center of a Shear storm is the trickiest to find because the shear prevents tall clouds from developing on one side of the cyclone. This asymmetry makes it harder to find the center.</p>
          <p>In some cases, like the example shown here, you can still see a small swirl in the gray and pink (warmer) clouds. If you see one of these, follow the swirl as it spirals into the center.</p>
          <p>Sometimes these shallow clouds are difficult to find on infrared images. If you have trouble with the swirl method, look at the shield of cold clouds. In Shear storms, the colors will be very close together on one side of the storm, sometimes aligned in a straight line. That’s where the cold clouds are developing, before being blown away by the shear. The center of the storm will usually be nearby.</p>
          <p><img src="images/field-guide/center-shear.jpg" data-popup="#center-shear-guide right" /></p>
          <div id="center-shear-guide" class="popup-content"><img src="images/field-guide/center-shear.jpg" /></div>
        </section>
      '''

      centerEyeSize: '''
        <h3>Click the center of the storm, then pick the size closest to the eye edge</h3>
        <p>A cyclone’s eye forms at its center of circulation, where descending air creates a mostly cloudless and rain free area.   You can identify an eye by finding a very warm area near the center of the storm surrounded by a ring of very cold clouds.  Often you are actually seeing straight through the storm to the land or ocean below.  To pinpoint the center of the storm, simply find the center of the eye.</p>
        <p>Storms with smaller eyes typically have  tighter and stronger circulation, and therefore a stronger storm.  You also  need to determine the eye’s size.  To do this, select the circle that best matches the size of the eye and drag it with your mouse so that it traces the eye.  If you need to change the size, click on a different-sized circle and try again.  For this purpose, you can think of the edge of the eye as the point where the colors are closest together.</p>
        <p><img src="images/field-guide/center-eye.jpg" data-popup="#center-eye-guide right" /></p>
        <div id="center-eye-guide" class="popup-content"><img src="images/field-guide/center-eye.jpg" /></div>
      '''

      surrounding: '''
        <h3>Which colors completely surround the eye?</h3>
        <p>For this step, you are looking for the coldest color which completely surrounds the eye of the cyclone, in an unbroken ring.  It doesn’t matter how thick or thin the ring is, or even if it’s not circular, only that it is continuous, with no breaks, all the way around.</p>
        <p>Keep in mind that these storms can be thought of as a layer cake, with warmer layers underneath the colder ones.  For example, if you removed all of the light blue colors, you would see yellow beneath them, and orange beneath those.  In the example below, the cyan ring doesn’t quite connect all the way around, but the light blue beneath it does. Since the light blue completes a ring, that means that yellow, orange, and all the layers of the cake beneath it also wrap all the way around.  You only need to select light blue.</p>
        <p>Cloud temperatures decrease with height, so you can identify the strongest storms by finding the coldest cloud tops.  Using the infrared imagery that you see here, that task becomes very simple.</p>
        <p>The eye of a tropical cyclone is surrounded by a ring of tall clouds called the eyewall. By identifying which colors surround the eye of the storm, you’ll determine how tall these clouds are, which helps estimate the strength of the cyclone itself.</p>
        <p><img src="images/field-guide/surrounding.jpg" data-popup="#surrounding-guide right" /></p>
        <div id="surrounding-guide" class="popup-content"><img src="images/field-guide/surrounding.jpg" /></div>
      '''

      exceeding: '''
        <h3>Choose the colors completely surrounding the eye that is at least 0.5° thick</h3>
        <p>This question is very similar to the previous one, except this time, you are specifically looking for colors of a certain thickness.  Previously, you were only finding a continuous ring, no matter how thick or thin.</p>
        <p>Click on the image and a small circle will appear that follows your mouse pointer around.  Find the coldest color that completely surrounds the eye and is also as thick as that circle at all points around the ring.  This tells us not only how tall the clouds are, but how widespread as well.  Storms with a larger area of cold clouds are typically more intense.</p>
        <p>In the last step, we found that light blue wrapped all the way around the storm. This light blue is thick enough in most places, but not southwest of the eye. In that region we find some yellow peaking through our measuring tool. That small bit of yellow is enough to eliminate the light blue for this step.</p>
        <p>At first glance the yellow might not seem thick enough either. However, remember how a storm is like a layer cake.  If one ring isn’t quite thick enough, imagine removing it and exposing the next warmer color below, and so forth until you find one thick enough.  There is a yellow layer underneath the blue one, so we can consider these blues as part of the yellow. In that case, the yellow is more than thick enough.</p>
        <p><img src="images/field-guide/exceeding.jpg" data-popup="#exceeding-guide right" /></p>
        <div id="exceeding-guide" class="popup-content"><img src="images/field-guide/exceeding.jpg" /></div>
      '''

      feature: '''
        <h3>Does the band wrap less than a quarter, about a quarter, half or more?</h3>
        <p>Strong tropical cyclones often have long spiral bands. A band is defined as a spiral arm that is orange or colder, separated from the main storm by a wedge of red or warmer. For this step, you will determine how far the band wraps around the storm.</p>
        <p>Choose an icon from the three below the image to indicate which best matches the amount of banding you see in the storm above. You’ll determine whether the band wraps less than a quarter-way around the storm, about a quarter-way around the storm, or half-way or more around the storm. Some storms don’t have any spiral bands at all. In those cases select the leftmost icon.</p>
        <p>The example here has a wide band along the north side of the storm. This band is relatively short and it doesn’t wrap very far around the storm’s center. In this case, you’d pick the icon on the left.</p>
        <p><img src="images/field-guide/feature-embedded-center.jpg" data-popup="#feature-guide right" /></p>
        <div id="feature-guide" class="popup-content"><img src="images/field-guide/feature-embedded-center.jpg" /></div>
      '''

      blue: '''
        <h3>Which colors wrap most of the way around the band?</h3>
        <p>Colder, taller clouds release more energy into a tropical cyclone. We identify these taller storms in infrared satellite images by looking for colder cloud tops. Remember white and blue represent the coldest clouds and pink and grey represent the warmest clouds. As you might expect, stronger tropical cyclones will have more of these tall, cold clouds.</p>
        <p>For this step, you are trying to find the primary color of the Curved Band itself.  That will provide information on the tropical cyclone’s strength.  Simply look at the band and pick the coldest color that extends along most of the band.   In the example here, there are some patches of light blue, and even cyan, but they are too sparse to be considered widespread, so you would click yellow.</p>
        <p><img src="images/field-guide/color.jpg" data-popup="#color-guide right" /></p>
        <div id="color-guide" class="popup-content"><img src="images/field-guide/color.jpg" /></div>
      '''

      curve: '''
        <h3>How far does the main band wrap?</h3>
        <p>The primary measure of a Curved Band storm’s strength is the length of the band itself. The longer the band, the stronger the storm.  Focus on how far around the band wraps, and click on the picture that best matches it.  In this example, the band wraps around about one-half of a full circle, so we’d click the second picture below.</p>
        <p><img src="images/field-guide/wrap.jpg" data-popup="#wrap-guide right" /></p>
        <div id="wrap-guide" class="popup-content"><img src="images/field-guide/wrap.jpg" /></div>
      '''

      red: '''
        <h3>Click the red point nearest to the storm center that is associated with the main cloud feature</h3>
        <p>In this step, you are trying to find the distance from the center that you found to the storm’s main thunderstorms.  This tells us how tilted or straight the storm is, and therefore, how strong it is.  For this step, simply click on the edge of the cold clouds that is closest to the center that you marked in the last step.</p>
        <p>In the example here, the center (marked with a white crosshair) is just outside the main thunderstorms.  In some cases, the center will be within the cold colors, but we’ll still need to know how far the center is from the edge of the coldest clouds. Click the edge of the main storm (the nearest red point), and a second crosshair will appear.  The distance between these clicks will tell us the storm’s strength.</p>
        <p><img src="images/field-guide/red.jpg" data-popup="#red-guide right" /></p>
        <div id="red-guide" class="popup-content"><img src="images/field-guide/red.jpg" /></div>
      '''

      reveal:
        windAndPressure: 'Wind speed and pressure'
