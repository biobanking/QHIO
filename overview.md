# QHIO High-Level Terms

This document presents an overview of existing and required terms for processes and entities involved in quantitative histopathology imaging and analysis. Our immediate goal is to cover a narrow use case for breast cancer histopathology using two different modalities: hot spots and mitotic figures.


## Using this Document

This document is written in essay form, with links to relevant existing terms and required new terms in <b>bold</b>.

- [new terms spreadsheet]() (editable)
- [imported terms spreadsheet]() (not editable)
- [draft OWL file](qhio.owl)

To read OWL files you need to install [Protégé Desktop](http://protege.stanford.edu/products.php#desktop-protege).


## Ontologies

We draw on a wide range of Open Biomedical Ontologies, especially OBI and IAO:

- OBI: Ontology for Biomedical Investigations
- IAO: Information Artifact Ontology
- FMA: Foundational Model of Anatomy
- GO: Gene Ontology
- DOID: Human Disease Ontology
- OBIB: Ontology for Biobanking
- ERO: eagle-i Resource Ontology
- OGMS: Ontology for General Medical Science
- CL: Cell Type Ontology
- PRO: Protein Ontology


## Open Microscopy Environment

OME contains many relevant terms that we have not yet assessed:

- <http://www.openmicroscopy.org>
- [OME OWL file](ome.owl) (fixed version of <http://www.itee.uq.edu.au/eresearch/projects/fusion/ome>)


## Warning: Empty Terms

Ontologies are used to make true statements about the world. Terms such as "mass", "lesion", and "feature" are problematic because they are used to *avoid* making statements that might turn out to be false. It is futile to try to provide a precise definition for a term that is intended to be vague.

Instead of using these empty terms we can take advantage of our term hierarchies, which have very general terms at their root and then branch out into the very specific. We pick the most specific term we can, to the best of our knowledge.


## Anatomy, Physiology, and Disease

FMA covers human anatomy at all scales, but at the sub-cellular scale GO is much more detailed. GO also covers biological processes. For cell types we can draw on CL. These ontologies cover "canonical" biology, without disease.

- [human](http://purl.obolibrary.org/obo/NCBITaxon_9606)
- [breast](http://purl.obolibrary.org/obo/FMA_9601)
- [cell](http://purl.obolibrary.org/obo/GO_0005623)
- [adipocyte of breast](http://purl.obolibrary.org/obo/CL_0002617)
- [nucleus]( http://purl.obolibrary.org/obo/GO_0005634)
- [mitotic nuclear division](http://purl.obolibrary.org/obo/GO_0007067)

The [Ki67 protein](http://www.uniprot.org/uniprot/P46013) has a Protein Ontology ID (PRO_0000084301) but it is not resolving to a useful page.

For human pathology we will use DOID:

- [disease of cellular proliferation](http://purl.obolibrary.org/obo/DOID_14566)
- [cancer](http://purl.obolibrary.org/obo/DOID_162)
- [breast cancer](http://purl.obolibrary.org/obo/DOID_1612)
- [invasive ductal carcinoma](http://purl.obolibrary.org/obo/DOID_3008) (of the human breast)
- [pre-malignant neoplasm](http://purl.obolibrary.org/obo/DOID_0060071)
- [breast carcinoma in situ](http://purl.obolibrary.org/obo/DOID_8791)
- [ductal carcinoma in situ](http://purl.obolibrary.org/obo/DOID_0060074)


## Tissue Collection

OBI, OMIABIS, and ERO have many terms for collecting a tissue specimen from a patient, and OGMS has general medical terms.

- [patient role](http://purl.obolibrary.org/obo/OBI_0000093)
- [surgical procedure](http://purl.obolibrary.org/obo/OMIABIS_0001041)
- [collecting specimen from organism](http://purl.obolibrary.org/obo/OBI_0600005)
- [tissue specimen](http://purl.obolibrary.org/obo/OBI_0001479)

We can add more specific terms as needed.


## Tissue Preparation

OBI has a general terms [histological sample preparation](http://purl.obolibrary.org/obo/OBI_0000341), and some more specific terms for the parts of that process. We will need additional terms:

- [protocol](http://purl.obolibrary.org/obo/OBI_0000272)
- [inclusion criteria](http://purl.obolibrary.org/obo/OBI_0500027)
- [device](http://purl.obolibrary.org/obo/OBI_0000968)
    - [tissue embedding station](http://purl.obolibrary.org/obo/OBI_0001107)
    - [automatic staining machine](http://purl.obolibrary.org/obo/OBI_0001063)
    - [microscrope slide](http://purl.obolibrary.org/obo/OBI_0400170)
- [reagent](http://purl.obolibrary.org/obo/OBI_0001879)
    - **Ki67 stain**
- ChEBI has terms for H&E molecules, but we probably need terms for the dyes
  - [haematoxylin](http://purl.obolibrary.org/obo/CHEBI_51686)
  - [eosin YS dye](http://purl.obolibrary.org/obo/CHEBI_52053)
  - [histological dye](http://purl.obolibrary.org/obo/CHEBI_77178)
  - [Hematoxylin and eosin stain](http://purl.obolibrary.org/obo/ERO_0001605): Note this term refers to an assay, not a staining reagent
- [material processing](http://purl.obolibrary.org/obo/OBI_0000094)
    - [cell fixation](http://purl.obolibrary.org/obo/OBI_0600021)
    - **ischemia** (not the disease)
    - **tissue dehydration**
    - **tissue embedding**
    - [staining](http://purl.obolibrary.org/obo/OBI_0302887)
- **histological section**

OBIB terms will also be relevant when specimens are stored.


## Imaging

IAO and OBI have general terms for images and imaging, but we will have to be more specific.

- [image creation device](http://purl.obolibrary.org/obo/OBI_0000398)
    - [microscope](http://purl.obolibrary.org/obo/OBI_0400169)
    - **histological slide scanner**
        - specific model of scanner
- [image creation](http://purl.obolibrary.org/obo/OBI_0001007)
    - **histological slide scanning**
- [assay](http://purl.obolibrary.org/obo/OBI_0000070)
    - [imaging assay](http://purl.obolibrary.org/obo/OBI_0000185)
    - immunohistochemistry has recently been proposed as a new assay in OBI
- [image](http://purl.obolibrary.org/obo/IAO_0000101): The definition is restricted to 2D images, but we will probably want to include 3D images eventually.
    - **multiframe image**
- [data set](http://purl.obolibrary.org/obo/IAO_0000100)
    - **biomedical imaging dataset**
- parts and qualities of an image, or of the device that creates it
    - **magnification**
    - **resolution**
    - **pixel**
    - **color space**
- annotations
    - **image annotation creation** process
    - **region of interest**, its size, shape, and location
    - statements about regions of interest

OME terms will be relevant.


## Image Processing


IAO and OBI distinguish [software](http://purl.obolibrary.org/obo/IAO_0000010) from the [algorithm](http://purl.obolibrary.org/obo/IAO_0000064)(s) that it implements, and from the [data transformation](http://purl.obolibrary.org/obo/OBI_0200000)(s) that it performs. Many data transformations are already defined, but we will have to add more:

- pre-processing (need to be more specific)
- **image segmentation**
- [feature extraction](http://purl.obolibrary.org/obo/OBI_0001028)
- **feature selection**
- **feature classification**
- **clustering**

Specific algorithms would be individuals (not classes), but there will also be classes of algorithms.

We also need to talk about parameters for algorithms. IAO/OBI have some existing terms and modelling techniques for settings ([setting datum](http://purl.obolibrary.org/obo/IAO_0000140)) that might require modification.

- parameters of the algorithm
  - input
  - internal parameters
  - output

Again, OME terms will be relevant.


## Conclusions and Reporting

Whether measured by a human or a machine, we want to quantify characteristics of the tissue as seen in the images. We will have to define:

- **mitosis count**
- **hot spot**
- **Ki67 percentage**

We can then talk about the report:

- [documenting](http://purl.obolibrary.org/obo/IAO_0000572) process
- [drawing a conclusion](http://purl.obolibrary.org/obo/OBI_0001834)
- [report](http://purl.obolibrary.org/obo/IAO_0000088) (might not quite fit)

