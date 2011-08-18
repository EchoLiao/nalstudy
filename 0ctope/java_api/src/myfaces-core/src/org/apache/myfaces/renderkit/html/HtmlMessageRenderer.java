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

import java.io.IOException;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;

import org.apache.myfaces.buildtools.maven2.plugin.builder.annotation.JSFRenderer;
import org.apache.myfaces.shared_impl.renderkit.html.HtmlMessageRendererBase;

/**
 * 
 * @author Manfred Geiler (latest modification by $Author: slessard $)
 * @author Thomas Spiegl
 * @version $Revision: 701829 $ $Date: 2008-10-05 12:06:02 -0500 (Sun, 05 Oct 2008) $
 */
@JSFRenderer(renderKitId = "HTML_BASIC", family = "javax.faces.Message", type = "javax.faces.Message")
public class HtmlMessageRenderer extends HtmlMessageRendererBase
{
    // private static final Log log = LogFactory.getLog(HtmlMessageRenderer.class);

    @Override
    public void encodeEnd(FacesContext facesContext, UIComponent component) throws IOException
    {
        super.encodeEnd(facesContext, component); // check for NP
        renderMessage(facesContext, component);
    }

    @Override
    protected String getSummary(FacesContext facesContext, UIComponent message, FacesMessage facesMessage,
                                String msgClientId)
    {
        return facesMessage.getSummary();
    }

    @Override
    protected String getDetail(FacesContext facesContext, UIComponent message, FacesMessage facesMessage,
                               String msgClientId)
    {
        return facesMessage.getDetail();
    }
}