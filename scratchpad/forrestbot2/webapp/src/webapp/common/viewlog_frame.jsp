<%--
  Copyright 2002-2004 The Apache Software Foundation

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<html:html locale="true">
    <head>
        <title><tiles:insert attribute="title"/> - <c:out value="${project}"/></title>
    </head>
    <frameset rows="40,*">
        <html:frame framename="header" page="/viewlog_header.do" paramid="project" paramname="project"/>
        <html:frame framename="body" page="/viewlog_body.do" paramid="project" paramname="project"/>
    </frameset>
    <noframes>
      <html:link page="/viewlog_header.do" paramid="project" paramname="project">header</html:link>
      <html:link page="/viewlog_body.do" paramid="project" paramname="project">body</html:link>
    </noframes>
  </html:html>