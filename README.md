Docker image for running DeepSEA ([v0.94](http://deepsea.princeton.edu/media/code/deepsea.v0.94.tar.gz), June 1, 2016) for predicting, without retraining. As the default in the original code, it runs on CPU.

If you are looking for a docker that trains a new DeepSEA model on customized data, check out [our another repo](https://github.com/gifford-lab/deepsea-docker).

## Dependencies
+ [Docker](https://www.docker.com/) 

## Predict sequence-derived features
Here we show-case how to predict whether a list of 1001 bp sequences (in [FASTA](https://en.wikipedia.org/wiki/FASTA_format) format) reside the peaks of 919 histone mark, DNase-seq and TF ChIP-seq experiments

+ To run on the example data the DeepSEA authors provided:

	```
    docker pull haoyangz/deepsea-predict-docker
    docker run -v $(pwd)/output:/output --rm haoyangz/deepsea-predict-docker python rundeepsea.py examples/deepsea/example.fasta /output
    ```

	The output will be saved under a folder 'output' in the current directory. 

+ To predict on your own FASTA-formatted sequences:

	```
    docker pull haoyangz/deepsea-predict-docker
    docker run -v $FULL_PATH_TO_FA_FILE$:/infile.fasta  -v $FULL_PATH_TO_OUTPUTDIR$:/output --rm haoyangz/deepsea-predict-docker python rundeepsea.py /infile.fasta /output
    ```

    + `FULL_PATH_TO_FA_FILE`: the full path to input FASTA file
    + `FULL_PATH_TO_OUTPUTDIR`: the full path to output directory

	This mounts `FULL_PATH_TO_FA_FILE` as `/infile.fasta` and `FULL_PATH_TO_OUTPUTDIR` as `/output` to the docker container, then executes `rundeepsea.py` with `/infile.fasta` and `/output` as arguments. We include a [example.fasta](https://github.com/gifford-lab/deepsea-predict-docker/blob/master/example.fasta) in the directory for your to try.

## Other usage
For more usage, please refer to the original [README](https://github.com/gifford-lab/deepsea-predict-docker/blob/master/README_ori) in DeepSEA-0.94. Simply change the part of the code above after `haoyangz/deepsea-predict-docker` to match with the functionality.

**Note that the DeepSEA code will determine what to do based on the suffix of the input file.** If the DeepSEA functionality you use takes file format other than FASTA, for instance VCF file for scoring sequence variants, you will need to change both `infile.fasta` in the previous example to match the suffix. For instance if you are scoring a VCF file, you might want to run: 

docker run -v $FULL_PATH_TO_FA_FILE$:**/infile.vcf**  -v $FULL_PATH_TO_OUTPUTDIR$:/output --rm haoyangz/deepsea-predict-docker python rundeepsea.py **/infile.vcf** /output

## License
The original code is from the Troyanskaya lab, see [here](http://deepsea.princeton.edu/).
