<?xml version="1.0" encoding="UTF-8"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<xsl:stylesheet version = "1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:atom="http://www.w3.org/2005/Atom"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
  xmlns:doap="http://usefulinc.com/ns/doap#">
  <xsl:template match="/">
    {
      "items" : [
        <xsl:apply-templates/>
      ]
    } 
  </xsl:template>
  <xsl:template match="descriptors">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="descriptor">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="doap:Project">
    {
      <xsl:apply-templates/>
    },
  </xsl:template>
  <xsl:template match="doap:shortdesc">    
    shortdesc : <xsl:value-of select="."/>
  </xsl:template>
  <xsl:template match="doap:name">    
    name : <xsl:value-of select="."/>,
  </xsl:template>
  <xsl:template match="doap:homepage">    
    homepage : <xsl:value-of select="@rdf:resource"/>,
  </xsl:template>
</xsl:stylesheet>