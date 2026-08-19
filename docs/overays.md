# Trench maps as Ground Overlays in KML

... see trench-maps.md


## Images from War diaries

You need to specify latitude for north and south edges of your image, longitudes for east and west, and a rotation about the image centre.

Start by making your best guess for the edges of your bounding box and add a PlaceMark at its centre. Leave the rotation at 0 degrees for the time being.
From here, you need to move the centre you've marked to its actual location, then get the scaling right and rotation right.

Load the KML into Google Earth or your GIS of choice. Find the true location of the centre of your image and put a PlaceMark there.
You can then work out how to adjust your north, south, east and west values to translate the image so that it's centre ends up in the right place.
Next, play around with the rotation value of your GroundOverlay until you've got your image properly lined up.

In Google Earth (or your GIS of choice) you can measure distances.
On a WW1 trench map, the numbered squares (1 to 36) are 1000 yards on a side.
Make measurements to find the number of yards spanned by a trench map square in your image overlay, then do the sums to scale the width and height of the bounding box.
Change the north, south, east and west values accordingly, making sure that you leave the centre of the box where it is.

For various reasons concerning how maps are made and photographed, you're unlikely to get the image to register exactly with the ground truth.
If you like, you can 'tune' the GroundOvelay parameters to get the most interesting bits to match most closely.

## Using the overlay


# Results

I'm aiming to create data that can be re-used.
