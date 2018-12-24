#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "saledates.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    SaleDates* myDates = new SaleDates();
    myDates->AddDate(QDate(2018,12,11));
    myDates->AddDate(QDate(2018,12,21), SaleDates::DateState::BookedDate);
    myDates->AddDate(QDate(2018,11,11), SaleDates::DateState::SaleDate);

    SaleDates::declare();

    engine.rootContext()->setContextProperty("DatesModel", myDates);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    return app.exec();
}
