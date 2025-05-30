/**
 * Copyright IBM Corp. 2023
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ibm.bamoe.ilmt.springboot.pamoe;


import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.IOException;
import java.nio.file.Files;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE, classes = SpringbootTestApplication.class)
public class PAMOESwidTagGenTest {

    @Autowired
    PAMOESwidTagGen swidFileGenerator;

    @AfterEach
    public void cleanup() throws IOException {
        Files.deleteIfExists(swidFileGenerator.getFilePath());
    }

    @Test
    public void testGenerateSwidFile() throws IOException {
        assertTrue(Files.exists(swidFileGenerator.getFilePath()), "SWID file should be generated");

        String swidContent = Files.readString(swidFileGenerator.getFilePath());
        assertEquals(swidFileGenerator.getSwidContent(), swidContent, "SWID file content should match expected content");
    }

}