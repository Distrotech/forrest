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

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:xi="http://www.w3.org/2001/XInclude"
  xmlns:forrest="http://apache.org/forrest/templates/1.0" 
  >
  
  <xsl:key name="contract-name" match="forrest:properties" use="@name" />
  
  <xsl:template match="/">
    <xsl:for-each 
      select="//forrest:properties/*[count(. | key('contract-name', @name)[1]) = 1 and @css='true']">
      <xsl:sort select="@name" />
      <xi:include href="cocoon://get.contract-css.{@name}" />
    </xsl:for-each>
    <xsl:apply-templates select="//extra-css"/>
  </xsl:template>
  <xsl:template match="extra-css">
    <xsl:value-of select="."/>
  </xsl:template>
</xsl:stylesheet>
