#pragma once

#include <QtCore/QObject>

class Calculator : public QObject
{
    Q_OBJECT
public:
    explicit Calculator(QObject *parent = nullptr);

signals:

};

