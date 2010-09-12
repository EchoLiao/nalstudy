/*
 * @(#)ECPrivateKeySpec.java	1.4 05/11/17
 *
 * Copyright 2006 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */
package java.security.spec;

import java.math.BigInteger;

/**
 * This immutable class specifies an elliptic curve private key with 
 * its associated parameters.
 *
 * @see KeySpec
 * @see ECParameterSpec
 *
 * @author Valerie Peng
 * @version 1.4, 11/17/05
 *
 * @since 1.5
 */
public class ECPrivateKeySpec implements KeySpec {
    
    private BigInteger s;
    private ECParameterSpec params;

    /**
     * Creates a new ECPrivateKeySpec with the specified 
     * parameter values.
     * @param s the private value.
     * @param params the associated elliptic curve domain 
     * parameters.
     * @exception NullPointerException if <code>s</code>
     * or <code>params</code> is null.
     */
    public ECPrivateKeySpec(BigInteger s, ECParameterSpec params) {
        if (s == null) {
            throw new NullPointerException("s is null");
        }
        if (params == null) {
            throw new NullPointerException("params is null");
        }
	this.s = s;
	this.params = params;
    }
	
    /**
     * Returns the private value S.
     * @return the private value S.
     */
    public BigInteger getS() {
	return s;
    }

    /**
     * Returns the associated elliptic curve domain 
     * parameters.
     * @return the EC domain parameters.
     */
    public ECParameterSpec getParams() {
	return params;
    }
}
