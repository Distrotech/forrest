<?xml version="1.0"?>
<!--
  Copyright 2002-2005 The Apache Software Foundation or its licensors,
  as applicable.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->
<!--
This stylesheet contains templates for converting documentv11 to HTML.  See the
imported document2html.xsl for details.
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--  Templates for "toc" mode.  This will generate a complete
        Table of Contents for the document.  This will then be used
        by the site2xhtml to generate a Menu ToC and a Page ToC -->
  
  <xsl:template match="document">
    <xsl:apply-templates mode="toc"/>
  </xsl:template>
  <xsl:template match="body" mode="toc">
    <tocitems>
      <xsl:apply-templates select="section" mode="toc">
        <xsl:with-param name="level" select="1"/>
      </xsl:apply-templates>
    </tocitems>
  </xsl:template>
  <xsl:template match="section" mode="toc">
    <xsl:param name="level"/>
    <tocitem level="{$level}">
      <xsl:attribute name="href">#<xsl:call-template 
        name="generate-id"/></xsl:attribute>
      <xsl:attribute name="title">
        <xsl:value-of select="title"/>
      </xsl:attribute>
      <xsl:apply-templates mode="toc">
        <xsl:with-param name="level" select="$level+1"/>
      </xsl:apply-templates>
    </tocitem>
  </xsl:template>
  <xsl:template name="generate-id">
    <xsl:choose>
      <xsl:when test="@id">
        <xsl:value-of select="@id"/>
      </xsl:when>
      <xsl:when test="@title">
        <xsl:value-of select="@title"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="generate-id(.)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="node()|@*" mode="toc"/>
</xsl:stylesheet>