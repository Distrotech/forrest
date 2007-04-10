<?xml version="1.0"?>
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:site="http://apache.org/cocoon/lenya/sitetree/1.0">
  <xsl:template match="/">
<!--href="" xmlns="http://apache.org/forrest/linkmap/1.0"-->
    <site label="docu">
      <about label="About">
        <index label="Index" href="index.html" description="Welcome to Doco"/>
      </about>
      <xsl:apply-templates/>
    </site>
  </xsl:template>
  <xsl:template match="site:node">
    <xsl:element name="{@id}">
      <xsl:attribute name="href">
        <xsl:value-of select="@id"/>/</xsl:attribute>
      <xsl:attribute name="label">
        <xsl:value-of select="site:label"/>
      </xsl:attribute>
      <xsl:element name="{@id}">
        <xsl:attribute name="href">index_en.html</xsl:attribute>
        <xsl:attribute name="label">
          <xsl:value-of select="site:label"/>
        </xsl:attribute>
      </xsl:element>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>
  <xsl:template match="site:label"/>
</xsl:stylesheet>
