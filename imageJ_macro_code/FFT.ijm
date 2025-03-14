macro "Batch Bandpass Filter" {
    // Select input and output directories
    inputDir = getDirectory("Select the Input Folder");
    outputDir = getDirectory("Select the Output Folder");

    // Get list of image files in the input directory
    fileList = getFileList(inputDir);
    
    if (fileList.length == 0) {
        exit("No images found in the selected folder.");
    }

    // Loop through all files in the folder
    for (i = 0; i < fileList.length; i++) {
        fileName = fileList[i];

        // Process only .tif, .tiff, .jpg, .png files
        if (endsWith(fileName, ".tif") || endsWith(fileName, ".tiff") || endsWith(fileName, ".jpg") || endsWith(fileName, ".png")) {
            fullPath = inputDir + fileName;
            open(fullPath);
            print("Processing: " + fileName);

            // Apply Bandpass Filter (Modify parameters as needed)
            run("Bandpass Filter...", "filter_large=40 filter_small=0.01 suppress=None tolerance=5 autoscale saturate");

            // Save the filtered image in the output directory
            saveAs("Tiff", outputDir + fileName);
            close();
        }
    }

    print("Batch Processing Complete! Processed images saved in: " + outputDir);
}
