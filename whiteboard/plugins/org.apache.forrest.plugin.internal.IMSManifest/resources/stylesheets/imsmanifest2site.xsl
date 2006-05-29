<?xml version="1.0"?>
<!--
  Licensed to the Apache Software Foundation (ASF) under one or more
  license agreements.  See the NOTICE file distributed with
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
<!--
Stylesheet for generating site.xml from a IMS Manifest file.
-->

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ims="http://www.imsproject.org/xsd/imscp_rootv1p1p2"
  xmlns:adlcp="http://www.adlnet.org/xsd/adlcp_rootv1p2">
  
  <xsl:import href="pathutils.xsl"/>
  <xsl:import href="repositoryUtils.xsl"/>
  
  <xsl:output doctype-system="http://apache.org/forrest/dtd/tab-cocoon-v11.dtd"
    doctype-public="-//APACHE//DTD Cocoon Documentation Tab V1.1//EN"/>

  <xsl:template match="/">
    <site label="MyProj" 
      href="" 
      xmlns="http://apache.org/forrest/linkmap/1.0"
      tab="">
      
      <xsl:apply-templates/>
      
    </site>
  </xsl:template>
  
  <xsl:template match="ims:manifest">
    <xsl:param name="asset_base"/>
    <xsl:apply-templates>
      <xsl:with-param name="asset_base"><xsl:value-of select="$asset_base"/></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="ims:organizations">
    <xsl:param name="asset_base"/>
    <xsl:apply-templates select="ims:organization">
      <xsl:with-param name="asset_base"><xsl:value-of select="$asset_base"/></xsl:with-param>
    </xsl:apply-templates>
  </xsl:template>
  
  <xsl:template match="ims:organization">
    <xsl:param name="asset_base"/>
    <xsl:variable name="title">
      <xsl:choose>
        <xsl:when test="./ims:title">
          <xsl:value-of select="./ims:title"/>
        </xsl:when>
        <xsl:otherwise>
          FIXME: Organisation Title Missing
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="element_name">organisation</xsl:variable>
    <xsl:element name="{$element_name}">
      <xsl:attribute name="label"><xsl:value-of select="$title"/></xsl:attribute>
      <xsl:apply-templates select="ims:item">
        <xsl:with-param name="asset_base"><xsl:value-of select="$asset_base"/></xsl:with-param>
      </xsl:apply-templates>
    </xsl:element>
  </xsl:template>
    
  <xsl:template match="ims:item[@identifierref]">
    <xsl:param name="asset_base"/>
    <xsl:variable name="idref"><xsl:value-of select="@identifierref"/></xsl:variable>
    <xsl:variable name="repositoryCommand">
      <xsl:call-template name="getRepositoryCommand">
        <xsl:with-param name="path"><xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/@href"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="scoName">
      <xsl:call-template name="getSCOName">
        <xsl:with-param name="path"><xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/@href"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="repositoryURI">
      <xsl:call-template name="getRepositoryURI">
        <xsl:with-param name="path"><xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/@href"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
<sco><xsl:value-of select="$scoName"/></sco>
<repository><xsl:value-of select="$repositoryURI"/></repository>
<repositoryCommand><xsl:value-of select="$repositoryCommand"/></repositoryCommand>
    <xsl:choose>
      <xsl:when test="$repositoryCommand='getSCO'">
        <xsl:variable name="repositoryHREF">http://<xsl:value-of select="$repositoryURI"/>/<xsl:value-of select="$scoName"/>/src/documentation/content/xdocs/imsmanifest.xml</xsl:variable>
        <xsl:apply-templates select="document($repositoryHREF)/ims:manifest">
          <xsl:with-param name="asset_base">repositoryCommand/getSCO/<xsl:value-of select="$scoName"/>/repositoryURI/<xsl:value-of select="$repositoryURI"/>/</xsl:with-param>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="title"><xsl:value-of select="ims:title"/></xsl:variable>
        <xsl:variable name="package_base"><xsl:value-of select="$asset_base"/><xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/../../@xml:base"/></xsl:variable>
        <xsl:variable name="path_href">
          <xsl:choose>
            <xsl:when test="//ims:resources/ims:resource[@identifier=$idref]/ims:file">
              <xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/ims:file/@href"/>
      			</xsl:when>
			      <xsl:otherwise>
			        <xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/@href"/>
			      </xsl:otherwise>
	        </xsl:choose>
        </xsl:variable>
        <xsl:variable name="href_ext">
          <xsl:call-template name="ext">
            <xsl:with-param name="path"><xsl:value-of select="$path_href"/></xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="path_href_noext">
          <xsl:call-template name="path-noext">
            <xsl:with-param name="path"><xsl:value-of select="$path_href"/></xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="mimeType"><xsl:value-of select="//ims:resources/ims:resource[@identifier=$idref]/@type"/></xsl:variable>
        <xsl:variable name="href">
          <xsl:choose>
            <xsl:when test="$mimeType='text/xml'"><xsl:value-of select="$package_base"/><xsl:value-of select="$path_href_noext"/>.html</xsl:when>                        <xsl:when test="$mimeType='text/xml'"><xsl:value-of select="$package_base"/><xsl:value-of select="$path_href_noext"/>.html</xsl:when>
            <xsl:when test="$mimeType='application/vnd-sun-xml-impress'"><xsl:value-of select="$package_base"/><xsl:value-of select="$path_href_noext"/>.html</xsl:when>
            <xsl:when test="$mimeType='application/vnd-sun-xml-writer'"><xsl:value-of select="$package_base"/><xsl:value-of select="$path_href_noext"/>.html</xsl:when>                        
          	<xsl:otherwise>
          	  <xsl:value-of select="$package_base"/><xsl:value-of select="$path_href"/>
          	</xsl:otherwise>
         </xsl:choose>
        </xsl:variable>
        <xsl:variable name="element_name">item</xsl:variable>
        
        <xsl:element name="{$element_name}">
          <xsl:attribute name="id"><xsl:value-of select="@identifier"/></xsl:attribute>
          <xsl:attribute name="identifierref"><xsl:value-of select="$idref"/></xsl:attribute>
          <xsl:attribute name="label"><xsl:value-of select="$title"/></xsl:attribute>   
          <xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
          
          <xsl:apply-templates select="ims:item"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="ims:item[not(@identifierref)]">
    <xsl:variable name="title"><xsl:value-of select="ims:title"/></xsl:variable>
    <xsl:variable name="element_name">itemGroup</xsl:variable>
    
    <xsl:element name="{$element_name}">
      <xsl:attribute name="id"><xsl:value-of select="@identifier"/></xsl:attribute>
      <xsl:attribute name="label"><xsl:value-of select="$title"/></xsl:attribute>
      
      <xsl:apply-templates select="ims:item"/>
    </xsl:element>
    
  </xsl:template>
  
  <xsl:template match="adlcp:prerequisites">
    <xsl:variable name="idref"><xsl:value-of select="."/></xsl:variable>
    <xsl:variable name="title"><xsl:value-of select="//ims:item[@identifier=$idref]/ims:title"/></xsl:variable>
    <xsl:variable name="resource_idref"><xsl:value-of select="//ims:item[@identifier=$idref]/@identifierref"/></xsl:variable>
    <xsl:variable name="href"><xsl:value-of select="//ims:resources/ims:resource[@identifier=$resource_idref]/ims:file/@href"/></xsl:variable>
    
    <xsl:element name="prerequisite">
      <xsl:attribute name="label"><xsl:value-of select="$title"/></xsl:attribute>
      <xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
    </xsl:element>
  </xsl:template>
  
</xsl:stylesheet>
