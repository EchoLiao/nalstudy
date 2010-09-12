/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.myfaces.renderkit.html;

import org.apache.myfaces.buildtools.maven2.plugin.builder.annotation.JSFRenderer;
import org.apache.myfaces.buildtools.maven2.plugin.builder.annotation.JSFRenderers;
import org.apache.myfaces.shared_impl.renderkit.html.HtmlCheckboxRendererBase;


/**
 * 
 * @author Thomas Spiegl (latest modification by $Author: lu4242 $)
 * @author Anton Koinov
 * @version $Revision: 695059 $ $Date: 2008-09-13 18:10:53 -0500 (Sat, 13 Sep 2008) $
 */
@JSFRenderers(renderers={
    @JSFRenderer(
        renderKitId="HTML_BASIC",
        family="javax.faces.SelectBoolean",
        type="javax.faces.Checkbox"),   
    @JSFRenderer(
        renderKitId="HTML_BASIC",
        family="javax.faces.SelectMany",
        type="javax.faces.Checkbox")
})
public class HtmlCheckboxRenderer
        extends HtmlCheckboxRendererBase
{
    //private static final Log log = LogFactory.getLog(HtmlCheckboxRenderer.class);

}
