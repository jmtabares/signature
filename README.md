# Test Plan
## Bugdet Tab

#### Misc test cases
Test|Expected Result
------------ | ------------- 
On click Budget Link on the Tab when user is on budget tab | System diaplay the budget page 
On click Budget Link on the Tab when user is on report tab | System display the budget page

#### Add Item tests
On Budget table Add [Category] item with [Description] and [Value] 

Category|Description|Value|Expected Result|
------------ | ------------- | ------------- | -------------
Income|Test income |100| new income item is added into the budget table with positive value 100 and description "test income"
Income|Test income |-100| new income item is added into the budget table with positive value 100 and description "test income"
Misc|Test misc positive |100| new misc item is added into the budget table with positive value -100 and description "test misc"
Misc|Test misc negative |-100| new misc item is added into the budget table with positive value -100 and description "test misc"
Any Category not in (Income, Misc)|Test [category name] |100| new item is added into the budget table with positive value 100 and description "test [category name]"
#### Add item Edge Cases

Category|Description|Value|Expected Result|
------------ | ------------- | ------------- | -------------
Any | 1 char less than MAX | any valid | item is added
Any | Length equals to  MAX | any valid | item is added
Any | 1 char more than MAX | any valid | item is not added 
Any | any valid | MAX allowed | item is  added 
Any | any valid | MIN allowed | item is  added 
Any | any valid | >MAX allowed | item is not added 
Any | any valid | <MAX allowed | item is not added 

#### Math Tests for Add items
- On Budget table Add and item with a positive value (V)  (Income category)
Total inflow (TI )should growth from previous value (TIPV) to: TI=TIPV+V 
Total Outflow (TO) should not vary
Working Balance (WB) should be equals to:  WB=MOD[TI-TO], where MOD is the non signed value of the math operation (eg: if TI=10 and TO=100, then) 
WB = [-90] = 90)

- On Budget table Add and item with a negative value (V)  (any category except Income)
Total Outflow (TO )should growth from previous value (TOPV) to: TO=TOPV+V 
Total Inflow (TI) should not vary
Working Balance (WB) should be equals to:  WB=MOD[TI-TO], where MOD is the non signed value of the math operation (eg: if TI=10 and TO=100, then) 
WB = [-90] = 90)

#### Edit Item tests on category  or Description
Items Changed|Expected Result
------------- | -------------
Category| System display the item with the new category without change description and value. Total Inflow/Outflow and Work balance shall not vary
Description| System display the item with the new description without change Category and value. Total Inflow/Outflow and Work balance shall not vary

#### Edit item value test
on any case System display the item with without change Category and description

Actual Value | New Value |Actual Value > New Value |Expected Result | Example
------------- | ------------- | ------------- | ------------- | -------------
\> 0 |  \>0 | True | TO=TO, TI=PVTI - (IPV-INPV), WB=MOD[TI-TO] | PVTO=300, PVTI=200, WB=100, IPV=100, INPV= 50 => TO=300, TI=200-(100-50) = 150, WB=[150-300]=[-150]=150
\> 0 |  \>0 | False | TO=TO, TI=PVTI+(INPV-IPV),WB=MOD[TI-TO]   | PVTO=300, PVTI=200, WB=100, IPV=100, INPV=200  => TO=300, TI=200+(200-100)=300 , WB= [300-300]=0
\> 0 |  \<0 | NA | TO=PVTO-INNV, TI=PVTI-IPV, WB=MOD[TI-TO]     | PVTO=300, PVTI=200, WB=100, IPV=100, INNV=-100  => TO=300-(-100)=400, TI=200-100=100 , WB=[100-400]=[-300]=300
\< 0 |  \<0 | True |TI=TI, TO=PVTO+(INV-INNV), WB=MOD[TI-TO]    | PVTO=300, PVTI=200, WB=100, INV=-100, INNV=-200  => TO=300+(-100+200)=400, TI=200 , WB=[200-400]=[-200]=200
\< 0 |  \<0 | False | TI=TI, TO=PVTO+INV,WB=MOD[TI-TO]          | PVTO=300, PVTI=200, WB=100, INV=-100, INNV=-50  => TO=300+(-50)=250, TI=200 , WB=[200-250]=[-50]=50
\< 0 |  \>0 | NA |TO=TOPV+INV, TI=PVTI+INPV, WB=MOD[TI-TO]      | PVTO=300, PVTI=200, WB=100, INV=-100, INPV=50  => TO=300+(-100)=200, TI=200+50=250 , WB=[250-200]=50

(Same test cases, other way to understand)

- Value item with from positive value (IPV) to another positive value amount (INPV) 
If IPV > INPV => TO=TO, TI=PVTI - (IPV-INPV), WB=MOD[TI-TO]
If IPV < INPV => TO=TO, TI=PVTI+(INPV-IPV),WB=MOD[TI-TO]

Value from item with positive value (IPV) to negative value amount(INNV) 
TO=TOPV-INNV, TI=PVTI-IPV, WB=MOD[TI-TO] 

- Value from item with negative value (INV) to another negative value amount (INNV) 
If INV > INNV => TI=TI, TO=PVTO+(INV-INNV), WB=MOD[TI-TO]
If INV < INNV => TI=TI, TO=PVTO+INV,WB=MOD[TI-TO]

- Value from item with negative value amount (INV) to positive value amount (INPV) 
TO=PVTO+INV, TI=PVTI+INPV, WB=MOD[TI-TO]

#### **Clarifications:**
TO is always a unsigned representation of the sum of all negative items amounts (out flow), because this, the math has some changed symbols

- **IPV**= item with positive value amount
- **INPV**= item with new positive value amount
- **INV**= item with negative value amount
- **INNV**= item with new negative value amount
- **PVTI**= Previous value for Total Inflow
- **PVTO**= Previous value for Total Outflow

#### Delete Item
Amount value (AV)| Expected results | Examples
------------- | -------------  | ------------- 
\> 0 |  TO=Same as before, TI=Previous Value - AV , WB=MOD[TI-TO] | TO=200, TI=100, WB =100, AV=50 => TO=200, TI=100-50=50, WB = 150
\< 0 |  TO=Previous Value + AV, TI=Same as before, WB=MOD[TI-TO] | TO=200, TI=100, WB =100, AV=-50 => TO=200+(-50)150, TI=100, WB = 50
All items | TO=0, TI=0, WB=0 | NA


## Reporting Tab

#### Misc test cases
Test|Expected Result
------------ | ------------- 
On click Report Link on the Tab when user is on budget tab | System display the report page on the "inflow vs outflow" report
On click Report Link on the Tab when user is on report tab on any subsection| System display the report page on the "inflow vs outflow" report

##### Report behavior Test cases

Tab|Expected Result
------------ | ------------- 
Inflow vs outflow | System shall display a vertical graph bar representing the inflow and the outflow form the budget tab
Spending by category | System shall display a donught graph representing the outflow barr from the "Inflow vs Outflow" char
Any | System shall display the sum per category from the outflow  



#### E2E Test cases

###### Verify Values 
1. Open the app
2. verify app is on Budget Tab
3. Verify Work balance is the result of [Total Inflow - Total Outflow] without sign
4. Verify Total inflow = Sum all positive values
5. Verify Total outflow = Sum all negative values
6. Click on Report
7. Verify OutFlow categories and values are the same from the outflow on the budget table

###### Verify Values after add a new item with negative amount value
1. Open the app
2. verify app is on Budget Tab
3. Verify Work balance is the result of [Total Inflow - Total Outflow] without sign
4. Verify Total inflow = Sum all positive values
5. Verify Total outflow = Sum all negative values
6. Click on Report
7. Verify OutFlow categories and values are the same from the outflow on the budget table
8. Click on Budget
9. Add a new Misc item with description "Test misc" and Value "100"
9. Verify  Total Outflow growth by 100
10. Verify Work Balance =  MOD[Total Inflow - Total Outflow]
11. Click on Report 
12. Verify OutFlow categories and values are the same from the outflow on the budget table

###### Verify Values after add a new item with positive amount value
1. Open the app
2. verify app is on Budget Tab
3. Verify Work balance is the result of [Total Inflow - Total Outflow] without sign
4. Verify Total inflow = Sum all positive values
5. Verify Total outflow = Sum all negative values
6. Click on Report
7. Verify OutFlow categories and values are the same from the outflow on the budget table
8. Click on Budget
9. Add a new Misc item with description "Income" and Value "100"
9. Verify  Total Inflow growth by 100
10. Verify Work Balance =  MOD[Total Inflow - Total Outflow] 
11. Click on Report 
12. Verify OutFlow categories and values are the same from the outflow on the budget table

###### Verify Values after add a new item with positive amount value and edit as negative
1. Open the app
2. verify app is on Budget Tab
3. Verify Work balance is the result of [Total Inflow - Total Outflow] without sign
4. Verify Total inflow = Sum all positive values
5. Verify Total outflow = Sum all negative values
6. Click on Report
7. Verify OutFlow categories and values are the same from the outflow on the budget table
8. Click on Budget
9. Add a new Income  item with description "Test Income" and Value "100"
9. Verify  Total Inflow growth by 100
10. Verify Work Balance =  MOD[Total Inflow - Total Outflow] 
11. Click on Report 
12. Verify OutFlow categories and values are the same from the outflow on the budget table
13. Click on Budget
14. Edit the item with description "Test Income" and change "100" by "-100"
15. Verify Total Inflow decreased by 100
16. Verify  Total Outflow growth by 100
17. Click on Report
18. Verify OutFlow categories and values are the same from the outflow on the budget table

###### Verify Values after edit a category
1. Open the app
2. verify app is on Budget Tab
3. Delete all items on tab
4. Add a Misc item with value 100
5. Add a Grocery Item with value 100
6. Click on Report
7. Verify OutFlow categories and values are the same from the outflow on the budget table
8. Click on Budget
9. Edit the item with category Grocery and change by Misc
10. Click on Report
11. Verify only Misc category is in onflow chart 

## Execution instructions
run  "rake default --trace"      

           
**Available tags**           
@exercise 
