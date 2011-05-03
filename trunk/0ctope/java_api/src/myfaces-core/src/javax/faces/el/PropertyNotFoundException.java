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
package javax.faces.el;

/**
 * see Javadoc of <a href="http://java.sun.com/javaee/javaserverfaces/1.2/docs/api/index.html">JSF Specification</a>
 * 
 * @author Thomas Spiegl (latest modification by $Author: lu4242 $)
 * @version $Revision: 882395 $ $Date: 2009-11-19 22:15:53 -0500 (Thu, 19 Nov 2009) $
 * @deprecated
 */
public class PropertyNotFoundException extends EvaluationException
{
    private static final long serialVersionUID = -7271529989175141594L;

    // FIELDS

    // CONSTRUCTORS
    /**
     * @deprecated
     */
    public PropertyNotFoundException()
    {
        super();
    }

    /**
     * @deprecated
     */
    public PropertyNotFoundException(String message)
    {
        super(message);
    }

    /**
     * @deprecated
     */
    public PropertyNotFoundException(String message, Throwable cause)
    {
        super(message, cause);
    }

    /**
     * @deprecated
     */
    public PropertyNotFoundException(Throwable cause)
    {
        super(cause);
    }
}