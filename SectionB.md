WGU Task: Provide original code for function(s) in text format that perform the transformation(s) you identified in section A4.

Here is my user-defined function:
----------------------------------------------------------
CREATE OR REPLACE FUNCTION TransformActiveStatus (
  ActiveValue    INTEGER
)
RETURNS TEXT AS $$
BEGIN
  IF ActiveValue = 1
    THEN RETURN 'Active';
  ELSEIF ActiveValue = 0
    THEN RETURN 'Inactive';
  ELSE RETURN 'Unknown';
  END IF;
END;
$$ LANGUAGE plpgsql;
-----------------------------------------------------------

What it does:
Input: an integer (0 or 1)
Output: a readable label ("Inactive" or "Active")
