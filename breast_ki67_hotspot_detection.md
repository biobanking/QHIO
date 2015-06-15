# algorithm


## input

### a region of interest image

#### selected from

- a digitized whole slide image

	- scanned from

		- a physical slide

			- cut from 

				- a tissue biopsy

					- from breast

			- stained with 

				- Ki-67	

					- a immunohistochemical stain (IHC)

					- nuclear marker

					- prognostic marker

					- predictive marker

					- score

						- also known as index

						- defined as

							- the percentage of positively stained cells within the total number of malignant cells scored

	- scanned by 

		- a whole slide scanner

	- scanned at 

		- 40x resolution

## process

### segment

#### Ki-67 positive pixels

#### method

- visually meaningful segmentation

	- abbreviation

		- VMS

			- kmeans clustering

				- in the RGB space

			- projection into the Lab color space

			- entropy based histogram thresholding

- smoothing

	- Gaussian filter

		- sigma	

			- 1

### create 

#### a density map

- from

	- segmented image

- uses

	- image dependent filtering

### detect local maxima

#### from density map

### post-processing

#### area filtering

- threshold

	- 530

#### rules

- single hot spot

	- weak local maxima

		- threshold value 

			- 0.15

- multiple hot spots

	- threshold local maxima

		- threshold value 

			- 0.15

#### combining

- multiple hot spot at a single location

	- geodesic distance transform

### hot spots

#### marked by 

- local maxima

## output

### annotations

#### marking

- regions

	- hot spot

		- defined as

			- Hot spots are areas in which Ki67 staining is most prevalent

			- Within the literature, there has been no uniform approach to scoring hot spots.

#### polygons

## assessment

