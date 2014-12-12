/* Automates FEL with the following input. Written 10/1/2014 AGM. */

BASEDIR = "/Users/austin/Google Drive/Work/WilkeLab/flu_projects/evo_rate_v_time/NA/dNdS/17/gene/";
datafile="nucleotide.fasta";
treefile="nucleotide.tree";

inputRedirect = {};
inputRedirect["01"]="Universal";                  //Genetic code
inputRedirect["02"]=BASEDIR+datafile;             //Fasta file, full path
inputRedirect["03"]="MG94";                       //Choose Model
inputRedirect["04"]="Global";                     //Choose Parameter Estimate Type
inputRedirect["05"]=BASEDIR+treefile;             //Tree
inputRedirect["06"]="Proportional to input tree"; //What to do with the branch lengths

ExecuteAFile ("dNdS_helper/AnalyzeCodonData.bf", inputRedirect);
