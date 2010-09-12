/*
 * Copyright 1999-2002,2004 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.sun.org.apache.xerces.internal.dom;

import org.w3c.dom.ranges.RangeException;

/**
 * @xerces.internal
 * 
 * @version $Id: RangeExceptionImpl.java,v 1.2.6.1 2005/08/31 12:41:43 sunithareddy Exp $
 */

public class RangeExceptionImpl extends RangeException {
    
    /** Serialization version. */
    static final long serialVersionUID = -9058052627467240856L;
    
    public RangeExceptionImpl(short code, String message) {
        super(code,message);
    }
}
