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
package org.apache.myfaces.config.element;

/**
 * @author Manfred Geiler (latest modification by $Author: skitching $)
 * @version $Revision: 684459 $ $Date: 2008-08-10 06:13:56 -0500 (Sun, 10 Aug 2008) $
 */
public interface MapEntry
{
    // <!ELEMENT map-entry (key, (null-value|value))>

    public String getKey();
    public boolean isNullValue();
    public String getValue();

}
