#!/usr/bin/env python
# coding: utf-8

# In[27]:


import numpy as np
import pandas as pd 
import matplotlib.pyplot as plt
import seaborn as sns
import os
print(os.listdir("D:\\NCI_Course\\Sem 2\\Programming in Data Analytics\\PFDA-VM-Share"))


# In[28]:


df = pd.read_csv('D:\\NCI_Course\\Sem 2\\Programming in Data Analytics\\PFDA-VM-Share\\cars.csv')


# In[29]:


df.info()


# In[30]:


df.head()


# In[31]:


used_vehicles = df.drop(columns=['latitude', 'longitude'])


# In[32]:


used_vehicles.shape


# In[33]:


used_vehicles = used_vehicles[used_vehicles.price != 0]
used_vehicles.shape


# In[34]:


used_vehicles = used_vehicles[used_vehicles.price < 100000]
used_vehicles.shape


# In[35]:


used_vehicles = used_vehicles[used_vehicles.year > 1985]
used_vehicles.shape


# In[36]:


used_vehicles.odometer.quantile(.999)


# In[37]:


used_vehicles = used_vehicles[~(used_vehicles.odometer > 500000)]
used_vehicles.shape


# In[38]:


from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error as MSE
from sklearn.model_selection import train_test_split as split
import warnings
from sys import modules


# In[39]:


linear_features = used_vehicles[['odometer','year','price']]


# In[40]:


linear_features = linear_features.dropna()
linear_features.shape


# In[41]:


used_vehicles_train, used_vehicles_test = split(linear_features, train_size=0.75, random_state=4222)


# In[42]:


training_x = used_vehicles_train[['odometer','year']]
training_y = used_vehicles_train['price']


# In[43]:


used_vehicles_lm = LinearRegression(fit_intercept=True)


# In[44]:


used_vehicles_lm.fit(training_x, training_y)


# In[45]:


print("The model intercept is: {}".format(used_vehicles_lm.intercept_))
print("The model coefficients are: {}".format(used_vehicles_lm.coef_[0]))


# In[46]:


training_x['Price_prediction'] = used_vehicles_lm.predict(training_x)
training_x.head()


# In[47]:


training_rmse = np.sqrt(MSE(training_y, training_x['Price_prediction']))
print("RMSE = {:.2f}".format(training_rmse))


# In[48]:


veh_lm_test = LinearRegression()


# In[49]:


testing_x = used_vehicles_test[['odometer','year']]
testing_y = used_vehicles_test['price']


# In[50]:


veh_lm_test.fit(testing_x, testing_y)


# In[51]:


testing_x['price_prediction'] = veh_lm_test.predict(testing_x)
testing_x.head()


# In[52]:


testing_rmse = np.sqrt(MSE(testing_y, testing_x['price_prediction']))
print("RMSE = {:.2f}".format(testing_rmse))


# In[ ]:





# In[ ]:




