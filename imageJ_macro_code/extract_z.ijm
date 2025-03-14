macro "Extract 3rd Z-Slice from .tiff Files" {
    // Select input folder containing TIFF stacks
    inputDir = getDirectory("Select the Folder Containing TIFF Stacks");

    // Select output folder where extracted slices will be saved
    outputDir = getDirectory("Select the Output Folder for Extracted Slices");

    // Get list of all .tiff files in the folder
    fileList = getFileList(inputDir);
    
    if (fileList.length == 0) {
        exit("No .tiff files found in the selected folder.");
    }

    // Loop through all files in the input directory
    for (i = 0; i < fileList.length; i++) {
        fileName = fileList[i];

        // Process only .tiff files
        if (endsWith(fileName, ".tiff")) {
            fullPath = inputDir + fileName;

            // Open the TIFF file
            open(fullPath);
            title = getTitle();  // Store the opened image title
            
            // Check if the file contains at least 3 slices
            totalSlices = nSlices();
            if (totalSlices < 1) {
                print("Skipping: " + fileName + " (Not enough slices)");
                close();
                continue;
            }

            // Select the 3rd slice
            run("Set Slice...", "slice=1");

            // Create a new image with only the third slice
            run("Duplicate...", "title=Extracted_Z1");

            // Save the extracted slice in the output folder
            savePath = outputDir + replace(fileName, ".tiff", "_Z1.tif");
            saveAs("Tiff", savePath);
            print("Saved: " + savePath);

		

        }
    }

    print("Processing Complete! Extracted Z-slices saved in: " + outputDir);
}
