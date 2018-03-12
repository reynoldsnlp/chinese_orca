package org.fnlp.train.seg;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import org.fnlp.ml.eval.SeqEval;
import org.fnlp.train.tag.ModelOptimization;

public class SegRun {
	
	static String datapath = "../data";
	static String dicfile = datapath + "/FNLPDATA/train.dict";
	static String outputPath = "../data/FNLPDATA/seg-eval.txt";
	static String model = "../models/seg.m";
	static String trainfile = "../data/FNLPDATA/train.seg";
	static String testfile = "../data/FNLPDATA/test.seg";
	static String output = "../data/FNLPDATA/res.3col";
	
	static PrintWriter bw;

	public static void main(String[] args) throws Exception {		
		bw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(outputPath,true), "utf8"));		
		

		SegTrain seg;
		
		
		seg = new SegTrain();		
		seg.model = model;
		seg.train = trainfile;
		seg.testfile =testfile;
		
		seg.templateFile = "../data/template-seg-0";
		seg.iterNum = 3;
		seg.c = 0.001f;
		seg.minLen = 5;
		seg.train();		
		
		seg.templateFile = "../data/template-seg-1";
		seg.iterNum = 10;
		seg.c = 0.01f;
		seg.minLen = 5;
		seg.train();		
		
		seg.loadFrom(model);
		seg.templateFile = "../data/template-seg-2";;
		seg.iterNum = 5;
		seg.c = 0.005f;
		seg.minLen = 2;
		seg.train();		
		
		eval(seg);		
		
		/////////////////////////////////////////
		
		bw.println("优化");
		float thres = 0.00001f;
		bw.println(thres);
		
		ModelOptimization op = new ModelOptimization(thres);
		op.optimizeTag(model);
		
		eval(seg);
		/////////////////////////////////////////
		
		bw.println("优化");
		thres = 0.001f;
		bw.println(thres);
		op = new ModelOptimization(thres);
		op.optimizeTag(model);
		
		eval(seg);
		
		bw.close();

	}

	static void eval(SegTrain seg)
			throws UnsupportedEncodingException, FileNotFoundException,
			Exception, IOException {
		SeqEval ne;		
		
		if(bw==null)
			bw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(outputPath,true), "utf8"));		
		
		File modelF = new File(model);
		bw.println("模型大小:"+modelF.length()/1000000.0);
		
		seg.testfile = testfile ;
		seg.output = output;
		seg.hasLabel = true;
		seg.test();
		
		ne = new SeqEval();
		ne.readOOV(dicfile);
		ne.read(output);
		String res = ne.calcByType();
		bw.println(res);
		
	}

}
