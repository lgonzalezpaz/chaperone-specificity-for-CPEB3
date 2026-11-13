## Figure legends

**Figure 1. The client, not the chaperone, is what changed between fly and human.**
**a**, Modular architecture of the system. In Funes the J domain with its HPD
motif licenses the Hsp70 ATPase and the C-terminal region binds the client;
experimentally the two are separable. DNAJC8 conserves the first module and not
the second, because the client itself has been re-specified. **b**, Composition
of the structurally ordered amyloid cores, computed from the deposited
coordinates of Orb2 amyloid isolated from fly heads (6VPS), Funes-induced Orb2
amyloid (8YAC) and the human CPEB3 prion-like-domain-1 labile amyloid (8SPA).
The 6VPS and 8YAC cores are identical in sequence. **c**, The four clients
analysed in this work, placed on the two compositional axes that separate them.
Open triangles are the engineered Orb2 cores in which five glutamines of the Gln
ladder are replaced by aliphatic and aromatic residues (Protein Data Bank
9PX8, 9YWA and 9Y1V; unpublished depositions), which interpolate between the
wild-type Orb2 and human CPEB3 extremes on a fixed scaffold. The dashed arrow
marks the amide-to-aromatic axis referred to in the text as the grammar axis.
**d**, Per-residue relative solvent accessibility along each core, computed on
the complete deposited assembly by the Shrake–Rupley algorithm with the
Gly-X-Gly reference maxima of Tien *et al.* Circles mark aromatic residues. The
dashed line is the relative accessibility of 0.25 used to classify residues as
exposed. Colours throughout are from a categorical palette validated for
lightness band, chroma floor and colour-vision-deficiency separation, and every
series additionally carries a distinct marker, so identity is never carried by
colour alone.

**Figure 2. Conservation of the Hsp70-coupling module is independent of
everything else a candidate needs.**
**a**, Similarity of the J domain of each human J-domain protein to that of
Funes, as a Smith–Waterman score normalised by the Funes self-score. DNAJC8
exceeds every other human J-domain protein by a wide margin; the 16
highest-scoring are shown. **b**, The 42 brain-expressed human J-domain proteins
placed on conservation of the Hsp70-coupling module (Layer 1) against the
combined score for client-binding-region chemistry and neuronal context
(Layers 2 and 3), both as z-scores. The two axes are statistically independent.
DNAJC8 is the extreme point on the first axis and sits in the lower part of the
second. The dashed line traces the Pareto front.

**Figure 3. An independent screen shows that chaperone selectivity is set by
the client.**
**a**, Aggregation modulation scores for 65 chaperones measured against
HTT-polyQ and against mutant FUS by Rozales *et al.*, a data set not used
anywhere else in this study. Negative values denote alleviation of aggregation
and positive values aggravation. The two profiles are uncorrelated. **b**,
Out-of-sample performance of three nested models under leave-one-chaperone-out
cross-validation: a client main effect alone, that model plus chaperone
composition, and that model plus all 144 bilinear chaperone-class by
client-class products. The increment attributable to composition-level
complementarity is small, though statistically detectable. **c**, Distances in
the standardised eleven-feature client-grammar space. The two clients of the
screen are closer to the two amyloid cores of this study than the
grammar-mismatched pairings are to one another; the error bar is the standard
deviation over the four mismatched pairs.

**Figure 4. The Funes orthologue is in the wrong place; several other J-domain
proteins are in the right one.**
**a**, Brain expression against tissue-profile co-expression with CPEB3 for the
brain-expressed human J-domain proteins. DNAJC8 is abundant but shows no
co-expression with CPEB3; DNAJB2, DNAJA4 and DNAJC5 combine high brain
expression with strong co-expression. **b**, Median transcript abundance across
13 brain subregions and eight other tissues for CPEB3 and for the proteins
highlighted in **a**. The vertical rule separates brain from non-brain tissues.

**Figure 5. Association free energies of chaperone client-binding regions with
the amyloid cores.**
**a**, Potentials of mean force along the mass-weighted centroid separation of
the two chains, from umbrella sampling in the CALVADOS 2 residue-resolution
model at 310 K and 0.15 M ionic strength, referenced to the free-state plateau.
**b**, Standard-state association free energies for every system simulated,
grouped by client. Error bars are bootstrap standard deviations over the window
samples; the larger spread between the two independent replicas is given in
Table 3 and is the uncertainty that limits interpretation.

**Figure 6. A controlled grammar titration on an invariant Orb2 scaffold.**
**a**, Association free energy against the mean CALVADOS stickiness of the
client, for each chaperone client-binding region, across the wild-type Orb2
core and the engineered variants in which five glutamines are replaced by
aliphatic and aromatic residues at fixed length, register and scaffold.
**b**, The same values grouped by client. Because the model's cross term is
additive in the residue stickiness parameters, a dependence on client
stickiness is expected and is the dynamic range the method does resolve;
differences between chaperones at fixed client are what it does not.

**Figure 7. Interface map and in-silico alanine scan for the leading
candidate.**
**a**, Per-residue intermolecular contact frequency on the client, sampled from
the bound-state ensemble under a flat-bottom restraint alone, coloured by
residue class. **b**, Per-residue intermolecular interaction energy over the
same ensemble; the four residues contributing most are labelled and are the
substitutions proposed as negative controls. **c**, Change in the
standard-state association free energy on alanine substitution of the labelled
client residues and of the three chaperone residues contributing most, computed
with identical reduced-cost settings for wild type and each variant so that the
differences are internally comparable.

## Supplementary figure legends

**Figure S1. Maximum-likelihood phylogeny of the J domains.**
Aligned J domains of the 49 human J-domain proteins, Funes, *Drosophila* Mrj,
three *Saccharomyces cerevisiae* J-domain proteins and *Escherichia coli* DnaJ,
under the LG+G4 model selected by the Bayesian information criterion. Support
values are SH-aLRT and ultrafast bootstrap percentages from 1,000 replicates
each. Funes and DNAJC8 form a clade with 91.5 SH-aLRT and 98% bootstrap
support.

**Figure S2. Sensitivity of the association free energies.**
Effect on the standard-state association free energy of the top-ranked system
of varying the client-binding-region length cap, of treating histidine as
partially protonated at pH 7.0 rather than neutral, and of substituting the
CALVADOS 3 parameter set for CALVADOS 2.

**Figure S3. Umbrella-sampling diagnostics.**
Window occupancy histograms and adjacent-window overlap fractions for every
simulated system. Overlap below about 0.3 indicates windows too narrowly
restrained for the weighted histogram analysis to stitch reliably; the
production settings used here give a mean overlap above 0.45 in every system.
