

EXAMPLE_OUTPUTS = {
        'int': """
		Extract only int value.
		
		If the input is "私の出席率は60%です。", the example output is below.(Don't include percent when percent is specified.)
		{
				"extracted_value":"60"
		}


		If the input is "私の取得単位数は30です。", the example output is below.
		{
				"extracted_value":"30"
		}
	""",
        'float': """
		Extract only float value.
		
		If the input is "私のGPAは3.0です。", the example output is below.
		{
				"extracted_value":"3.0"
		}
	""",
        'bool': """
		Understand user prompt and convert it to boolean value.(true or false)
		
		If the input is "希望しません", the example output is below.
		{
				"extracted_value":"false"
		}
		
		If the input is "希望します。", the example output is below.
		{
				"extracted_value":"true"
		}
""",
    'str': """
	
	If the input is "私の悩み事は数学が難しいいことです" the example output is below.
	{
			"extracted_value":"難しいいことです"
	}

	If the input is "私の悩み事は朝起きれないことです" the example output is below.
	{
			"extracted_value":"朝起きれないことです"
	}
"""
}
