/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.forrest.dispatcher.helper;

import javax.xml.stream.FactoryConfigurationError;
import javax.xml.stream.Location;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLReporter;

public class StAXHelper {

    public static XMLInputFactory getValidatingFactory() throws FactoryConfigurationError {
        XMLInputFactory factory;
        factory = XMLInputFactory.newInstance();
        factory.setProperty("javax.xml.stream.isValidating", Boolean.TRUE);
        factory.setXMLReporter(new XMLReporter() {
            public void report(String message, String errorType,
                    Object relatedInformation, Location location) {
                System.err.println("Problem in " + location.getPublicId());
                System.err.println("at line " + location.getLineNumber()
                        + ", column " + location.getColumnNumber());
                System.err.println(message);
            }
        });
        return factory;
    }

    public StAXHelper() {
        super();
    }

}