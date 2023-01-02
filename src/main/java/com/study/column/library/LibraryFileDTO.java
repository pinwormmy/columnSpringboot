package com.study.column.library;

import lombok.Data;

@Data
public class LibraryFileDTO {

    private int postNum;
    private int fileNum;
    private String originalFileName;
    private String filePath;
    private int fileSize;

}
